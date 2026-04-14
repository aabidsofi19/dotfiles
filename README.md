# dotfiles

Personal dev environment. Managed with GNU Stow.

## Philosophy

Every decision in this repo is filtered through four rules, in order:

**1. Stability** -- Bulletproof. I tinker, but I ship. Nothing auto-updates
silently. No plugin pulls HEAD. No config that works "most of the time."
A fresh clone on a new machine must work on the first try, every time.

**2. Functionality** -- Feature-rich, zero dead weight. Every tool and plugin
earns its spot by solving a real, recurring problem. "Saves 10 minutes a year"
is not a justification. If I can't explain when I last used it, it's gone.

**3. Performance** -- Fast and efficient. Sub-second shell startup. Lazy-loaded
plugins. No background daemons polling. If something makes the system feel
sluggish, it doesn't belong here.

**4. Looks** -- Modern, clean, pleasing. The terminal is where I live; it
should look like I give a damn. Tokyonight everywhere, consistent palette,
good typography. No riced-out chaos, no defaults either.

When these conflict, the order wins. A stable tool beats a fast but flaky one.
A useful tool beats a pretty but hollow one. But there is no excuse for ugly.

## Structure

```
~/dotfiles/
├── bat/            .config/bat/config
├── btop/           .config/btop/btop.conf
├── fish/           .config/fish/{config.fish, completions/, ...}
├── fonts/          .local/share/fonts/{berkeley-mono/, zed-mono/}
├── ghostty/        .config/ghostty/config.ghostty
├── git/            .gitconfig
├── nvim/           .config/nvim/{init.lua, lua/...}
├── starship/       .config/starship/starship.toml
├── zsh/            .config/zsh/{.zshrc, zshenv, zprofile} + .zshenv
├── packages.toml   Canonical list of programs
├── scripts/        OS-specific installers
│   ├── install-fedora.sh
│   └── install-macos.sh
└── Makefile        Orchestration
```

Each top-level directory is a **stow package**. Its internal tree mirrors `$HOME`.
Running `stow nvim` creates symlinks from `~/.config/nvim/*` pointing into this repo.

## Quick Start

```bash
# Clone
git clone git@github.com:aabidsofi19/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install programs (auto-detects OS)
make install

# Symlink configs into $HOME
make stow
```

## Usage

```bash
make stow             # Symlink all packages
make unstow           # Remove all symlinks
make restow           # Unstow + stow (cleans stale links)
make stow-nvim        # Symlink a single package
make unstow-fish      # Remove a single package
make install          # Auto-detect OS, install everything
make install-fedora   # Fedora/DNF only
make install-macos    # macOS/Homebrew only
make dry-run          # Preview install without touching anything
```

## Packages

| Stow Package | What It Configures |
|---|---|
| `nvim` | Neovim -- LSP, completion, formatting, treesitter, telescope, git |
| `zsh` | Zsh -- XDG layout, vi bindings, history, completion, fzf, zoxide |
| `fish` | Fish -- aliases, starship, zoxide, fzf, kubernetes shortcuts |
| `ghostty` | Ghostty terminal -- tokyonight colors, Berkeley Mono font |
| `starship` | Starship prompt -- minimal, fast, shows git/k8s context |
| `bat` | bat -- pager config |
| `btop` | btop -- system monitor |
| `git` | Git -- user identity |
| `fonts` | Berkeley Mono, Zed Mono -- stowed to `~/.local/share/fonts/` |

See [`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md) for the full
Neovim keybind reference.

## Adding a New Package

1. Create the stow directory: `mkdir -p newpkg/.config/newpkg/`
2. Add your config file: `newpkg/.config/newpkg/config`
3. Add it to `PACKAGES` in the `Makefile`
4. Add its install entry to `packages.toml` and the relevant `scripts/install-*.sh`
5. `make stow-newpkg`

## Adding a New Program

1. Add it to `packages.toml` under the right category
2. Add the OS-specific package name to `scripts/install-fedora.sh` and/or `scripts/install-macos.sh`
3. `make install`

## Design Decisions

These exist to enforce the philosophy. Don't change them without good reason.

- **GNU Stow over custom symlink scripts.** Stow is a single, well-tested binary
  that's been stable since 1993. It handles edge cases (stale links, tree folding,
  conflict detection) that hand-rolled scripts get wrong.

- **One stow package per tool.** Allows `make stow-nvim` without touching fish.
  Granular control, no blast radius.

- **`packages.toml` as source of truth.** Every program this setup needs is
  listed there. The install scripts parse it directly -- no duplicated lists,
  no drift between what's documented and what's installed.

- **Idempotent install scripts.** Every script can run 100 times safely. They skip
  what's already installed, never force-remove, never modify system configs beyond
  package installation. `--dry-run` flag on everything.

- **No auto-updates anywhere.** Neovim plugins pin to releases or lockfile commits.
  Install scripts don't run unattended upgrades. You update when you decide to.

- **XDG-compliant zsh.** `.zshenv` in `$HOME` bootstraps to `~/.config/zsh/`.
  Keeps the home directory clean.

- **Tokyonight Night everywhere.** One colorscheme across nvim and ghostty.
  Consistent visual language, zero context-switching friction.
