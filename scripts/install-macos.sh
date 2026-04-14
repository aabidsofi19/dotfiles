#!/usr/bin/env bash
# scripts/install-macos.sh -- Idempotent package installer for macOS/Homebrew
# Usage: ./scripts/install-macos.sh [--dry-run]
#
# Reads packages.toml as the single source of truth.
# Safe to run multiple times. Homebrew skips already-installed packages.
# Does NOT run anything as root (Homebrew refuses root anyway).

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

if [[ "$(uname -s)" != "Darwin" ]]; then
    err "This script is for macOS only."
    exit 1
fi

if [[ "$DRY_RUN" == true ]]; then
    warn "DRY RUN -- no packages will be installed"
fi

# ── Homebrew ────────────────────────────────────────────────────────

install_homebrew() {
    if command_exists brew; then
        log "Homebrew already installed."
        return
    fi

    log "Installing Homebrew..."
    if [[ "$DRY_RUN" == true ]]; then
        return
    fi

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# ── Brew packages (parsed from packages.toml) ──────────────────────

install_brew_packages() {
    log "Installing Homebrew packages..."

    local all_packages
    mapfile -t all_packages < <(get_os_packages brew)

    local to_install=()
    for pkg in "${all_packages[@]}"; do
        if brew list "$pkg" &>/dev/null; then
            continue
        fi
        to_install+=("$pkg")
    done

    if [[ ${#to_install[@]} -eq 0 ]]; then
        log "All Homebrew packages already installed."
        return
    fi

    log "Packages to install: ${to_install[*]}"

    if [[ "$DRY_RUN" == true ]]; then
        return
    fi

    brew install "${to_install[@]}"
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

# ── Font cache ──────────────────────────────────────────────────────

refresh_font_cache() {
    log "Fonts are stowed to ~/.local/share/fonts/"
    log "On macOS, you may also want to open Font Book and install them manually,"
    log "or copy them to ~/Library/Fonts/."
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

    # Ensure brew's zsh is in /etc/shells
    if ! grep -qF "$target_shell" /etc/shells 2>/dev/null; then
        log "Adding $target_shell to /etc/shells..."
        if [[ "$DRY_RUN" != true ]]; then
            echo "$target_shell" | sudo tee -a /etc/shells >/dev/null
        fi
    fi

    log "Changing default shell to zsh..."
    if [[ "$DRY_RUN" != true ]]; then
        chsh -s "$target_shell" || warn "Failed to change shell. Run: chsh -s $target_shell"
    fi
}

# ── Main ────────────────────────────────────────────────────────────

main() {
    log "macOS package installer"
    log "======================="
    log "Reading from: $PACKAGES_FILE"
    echo

    install_homebrew
    install_brew_packages
    install_go_tools
    install_npm_globals
    refresh_font_cache
    set_default_shell

    echo
    log "Done. Open a new terminal or run: exec zsh"
}

main
