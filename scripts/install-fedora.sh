#!/usr/bin/env bash
# scripts/install-fedora.sh -- Idempotent package installer for Fedora/DNF
# Usage: ./scripts/install-fedora.sh [--dry-run]
#
# Reads packages.toml as the single source of truth.
# Safe to run multiple times. DNF skips already-installed packages.
# Does NOT run anything as root without sudo, never force-removes, never
# touches system configs outside of package installation.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/parse-packages.sh"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

log()  { printf "${GREEN}[+]${NC} %s\n" "$*"; }
warn() { printf "${YELLOW}[!]${NC} %s\n" "$*"; }
err()  { printf "${RED}[x]${NC} %s\n" "$*" >&2; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

# ── Pre-flight checks ──────────────────────────────────────────────

if ! command_exists dnf; then
    err "dnf not found. This script is for Fedora/RHEL-based systems."
    exit 1
fi

if [[ "$DRY_RUN" == true ]]; then
    warn "DRY RUN -- no packages will be installed"
fi

# ── DNF packages (parsed from packages.toml) ───────────────────────

install_dnf_packages() {
    log "Installing DNF packages..."

    local all_packages
    mapfile -t all_packages < <(get_os_packages dnf)

    local to_install=()
    for pkg in "${all_packages[@]}"; do
        if rpm -q "$pkg" &>/dev/null; then
            continue
        fi
        to_install+=("$pkg")
    done

    if [[ ${#to_install[@]} -eq 0 ]]; then
        log "All DNF packages already installed."
        return
    fi

    log "Packages to install: ${to_install[*]}"

    if [[ "$DRY_RUN" == true ]]; then
        return
    fi

    sudo dnf install -y "${to_install[@]}"
}

# ── Go tools (parsed from packages.toml [go] section) ──────────────

install_go_tools() {
    if ! command_exists go; then
        warn "Go not found, skipping Go tools."
        return
    fi

    log "Installing Go tools..."

    local tools
    mapfile -t tools < <(get_section_packages go)

    for tool in "${tools[@]}"; do
        if [[ "$DRY_RUN" == true ]]; then
            log "  Would install: $tool"
        else
            log "  Installing: $tool"
            go install "$tool" || warn "Failed to install $tool"
        fi
    done
}

# ── npm globals (parsed from packages.toml [npm] section) ──────────

install_npm_globals() {
    local npm_cmd=""
    if command_exists bun; then
        npm_cmd="bun"
    elif command_exists npm; then
        npm_cmd="npm"
    else
        warn "Neither bun nor npm found. Skipping npm globals."
        return
    fi

    log "Installing npm globals via $npm_cmd..."

    local packages
    mapfile -t packages < <(get_section_packages npm)

    for pkg in "${packages[@]}"; do
        if [[ "$DRY_RUN" == true ]]; then
            log "  Would install: $pkg"
        else
            log "  Installing: $pkg"
            "$npm_cmd" install -g "$pkg" || warn "Failed to install $pkg"
        fi
    done
}

# ── Cargo tools (parsed from packages.toml [cargo] section) ────────

install_cargo_tools() {
    if ! command_exists cargo; then
        warn "Cargo not found. Skipping cargo tools."
        warn "Install Rust: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
        return
    fi

    log "Installing Cargo tools..."

    local tools
    mapfile -t tools < <(get_section_packages cargo)

    for tool in "${tools[@]}"; do
        if command_exists "$tool"; then
            log "  $tool already installed."
        elif [[ "$DRY_RUN" == true ]]; then
            log "  Would install: $tool"
        else
            log "  Installing: $tool"
            cargo install "$tool" || warn "Failed to install $tool"
        fi
    done
}

# ── Font cache ──────────────────────────────────────────────────────

refresh_font_cache() {
    if command_exists fc-cache; then
        log "Refreshing font cache..."
        if [[ "$DRY_RUN" != true ]]; then
            fc-cache -fv ~/.local/share/fonts/ 2>/dev/null || true
        fi
    fi
}

# ── Set default shell ──────────────────────────────────────────────

set_default_shell() {
    local target_shell
    target_shell="$(command -v zsh 2>/dev/null || true)"

    if [[ -z "$target_shell" ]]; then
        warn "zsh not found, skipping shell change."
        return
    fi

    if [[ "$SHELL" == "$target_shell" ]]; then
        log "Default shell is already zsh."
        return
    fi

    log "Changing default shell to zsh..."
    if [[ "$DRY_RUN" != true ]]; then
        chsh -s "$target_shell" || warn "Failed to change shell. Run: chsh -s $target_shell"
    fi
}

# ── Main ────────────────────────────────────────────────────────────

main() {
    log "Fedora package installer"
    log "========================"
    log "Reading from: $PACKAGES_FILE"
    echo

    install_dnf_packages
    install_go_tools
    install_npm_globals
    install_cargo_tools
    refresh_font_cache
    set_default_shell

    echo
    log "Done. Open a new terminal or run: exec zsh"
}

main
