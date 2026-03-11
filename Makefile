# Dotfiles Makefile
# Usage:
#   make stow          -- symlink all packages into $HOME
#   make unstow        -- remove all symlinks
#   make restow        -- re-symlink (unstow + stow, cleans stale links)
#   make stow-PKG      -- symlink a single package (e.g. make stow-nvim)
#   make install        -- detect OS and install packages
#   make install-fedora -- install packages on Fedora
#   make install-macos  -- install packages on macOS
#   make dry-run        -- show what install would do without doing it

DOTFILES := $(shell pwd)
TARGET   := $(HOME)

# Every top-level directory that contains a stow-ready tree.
# Excludes scripts/, .git/, and any non-package dirs.
PACKAGES := bat btop fish fonts ghostty git nvim starship zsh

.PHONY: help stow unstow restow install install-fedora install-macos dry-run $(addprefix stow-,$(PACKAGES)) $(addprefix unstow-,$(PACKAGES))

help:
	@echo "dotfiles"
	@echo "========"
	@echo ""
	@echo "  make stow           Symlink all packages into \$$HOME"
	@echo "  make unstow         Remove all symlinks"
	@echo "  make restow         Re-symlink (cleans stale links)"
	@echo "  make stow-PKG       Symlink one package (e.g. make stow-nvim)"
	@echo "  make unstow-PKG     Unsymlink one package"
	@echo "  make install        Detect OS and install packages"
	@echo "  make install-fedora Install packages on Fedora/DNF"
	@echo "  make install-macos  Install packages on macOS/Homebrew"
	@echo "  make dry-run        Preview install without changes"
	@echo ""
	@echo "Packages: $(PACKAGES)"

# ── Stow targets ───────────────────────────────────────────────────

stow:
	@echo "Stowing: $(PACKAGES)"
	@for pkg in $(PACKAGES); do \
		echo "  -> $$pkg"; \
		stow --verbose=1 --restow --target="$(TARGET)" "$$pkg" || exit 1; \
	done
	@echo "Done."

unstow:
	@echo "Unstowing: $(PACKAGES)"
	@for pkg in $(PACKAGES); do \
		echo "  -> $$pkg"; \
		stow --verbose=1 --delete --target="$(TARGET)" "$$pkg" 2>/dev/null || true; \
	done
	@echo "Done."

restow: unstow stow

# Per-package targets: make stow-nvim, make unstow-zsh, etc.
$(addprefix stow-,$(PACKAGES)):
	stow --verbose=1 --restow --target="$(TARGET)" $(subst stow-,,$@)

$(addprefix unstow-,$(PACKAGES)):
	stow --verbose=1 --delete --target="$(TARGET)" $(subst unstow-,,$@)

# ── Install targets ────────────────────────────────────────────────

install:
	@case "$$(uname -s)" in \
		Linux)  \
			if command -v dnf >/dev/null 2>&1; then \
				$(MAKE) install-fedora; \
			else \
				echo "Unsupported Linux distro. Add a script to scripts/ for your package manager."; \
				exit 1; \
			fi ;; \
		Darwin) $(MAKE) install-macos ;; \
		*) echo "Unsupported OS: $$(uname -s)"; exit 1 ;; \
	esac

install-fedora:
	@bash "$(DOTFILES)/scripts/install-fedora.sh"

install-macos:
	@bash "$(DOTFILES)/scripts/install-macos.sh"

dry-run:
	@case "$$(uname -s)" in \
		Linux)  bash "$(DOTFILES)/scripts/install-fedora.sh" --dry-run ;; \
		Darwin) bash "$(DOTFILES)/scripts/install-macos.sh" --dry-run ;; \
		*) echo "Unsupported OS: $$(uname -s)" ;; \
	esac
