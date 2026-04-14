#!/usr/bin/env bash
# scripts/parse-packages.sh
# Parses packages.toml and emits package lists for a given OS.
# Sourced by install-fedora.sh and install-macos.sh.
#
# Usage:
#   source parse-packages.sh
#   get_os_packages dnf    # prints dnf package names, one per line
#   get_section_packages npm  # prints raw pkg names from [npm] section

set -euo pipefail

PACKAGES_FILE="${PACKAGES_FILE:-$(dirname "${BASH_SOURCE[0]}")/../packages.toml}"

# get_os_packages <manager>
#   manager: "dnf" or "brew"
#   Reads all pkg lines from packages.toml EXCEPT [npm], [go], [cargo] sections.
#   For each line:
#     - If <manager> = "-", skip it
#     - If <manager> = "something", use that name
#     - Otherwise use the pkg name as-is
#   Prints one package name per line.
get_os_packages() {
    local manager="$1"
    local skip_sections="npm|go|cargo"
    local current_section=""

    while IFS= read -r line; do
        # Strip comments and trailing whitespace
        line="${line%%#*}"
        line="${line%"${line##*[![:space:]]}"}"
        [[ -z "$line" ]] && continue

        # Track section headers
        if [[ "$line" =~ ^\[([a-z_]+)\] ]]; then
            current_section="${BASH_REMATCH[1]}"
            continue
        fi

        # Skip non-OS sections
        if [[ "$current_section" =~ ^($skip_sections)$ ]]; then
            continue
        fi

        # Only process pkg lines
        [[ "$line" =~ pkg[[:space:]]*=[[:space:]]*\"([^\"]+)\" ]] || continue
        local pkg_name="${BASH_REMATCH[1]}"

        # Check for OS-specific override
        local os_name=""
        if [[ "$line" =~ $manager[[:space:]]*=[[:space:]]*\"([^\"]+)\" ]]; then
            os_name="${BASH_REMATCH[1]}"
        fi

        # "-" means skip on this OS
        if [[ "$os_name" == "-" ]]; then
            continue
        fi

        # Use override if present, otherwise default
        echo "${os_name:-$pkg_name}"
    done < "$PACKAGES_FILE"
}

# get_section_packages <section>
#   Reads pkg names from a specific section only.
#   Prints one package name per line.
get_section_packages() {
    local target_section="$1"
    local in_section=false

    while IFS= read -r line; do
        line="${line%%#*}"
        line="${line%"${line##*[![:space:]]}"}"
        [[ -z "$line" ]] && continue

        if [[ "$line" =~ ^\[([a-z_]+)\] ]]; then
            if [[ "${BASH_REMATCH[1]}" == "$target_section" ]]; then
                in_section=true
            else
                in_section=false
            fi
            continue
        fi

        if [[ "$in_section" == true ]]; then
            [[ "$line" =~ pkg[[:space:]]*=[[:space:]]*\"([^\"]+)\" ]] || continue
            echo "${BASH_REMATCH[1]}"
        fi
    done < "$PACKAGES_FILE"
}
