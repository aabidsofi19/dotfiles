# Neovim Config

Bulletproof Neovim configuration for Zig, Go, TypeScript, React, C/C++.

~16 plugins. Zero bloat. Everything earns its place.

## Structure

```
~/.config/nvim/
├── init.lua
└── lua/
    ├── core/
    │   ├── options.lua
    │   ├── keymaps.lua
    │   └── autocmds.lua
    └── plugins/
        ├── init.lua      # lazy.nvim bootstrap
        ├── ui.lua         # tokyonight + lualine + devicons
        ├── treesitter.lua # treesitter + textobjects + autotag
        ├── telescope.lua  # telescope + fzf-native + ui-select
        ├── lsp.lua        # lspconfig + mason + fidget
        ├── cmp.lua        # blink.cmp
        ├── formatting.lua # conform.nvim
        ├── git.lua        # gitsigns
        └── editor.lua     # oil.nvim + grug-far + mini.surround
```

## Plugins

| Plugin | Purpose |
|--------|---------|
| `tokyonight.nvim` | Colorscheme |
| `lualine.nvim` | Statusline |
| `nvim-web-devicons` | File icons |
| `nvim-treesitter` | Syntax highlighting, textobjects, incremental selection |
| `nvim-treesitter-textobjects` | Function/class/argument text objects |
| `nvim-ts-autotag` | Auto close/rename HTML/JSX tags |
| `telescope.nvim` | Fuzzy finder (files, grep, buffers, LSP) |
| `telescope-fzf-native` | Native fzf sorting for telescope |
| `telescope-ui-select` | Use telescope for `vim.ui.select` |
| `nvim-lspconfig` | LSP server configurations |
| `mason.nvim` | LSP/formatter/linter installer |
| `fidget.nvim` | LSP progress indicator |
| `blink.cmp` | Autocompletion |
| `conform.nvim` | Formatting (format-on-save) |
| `gitsigns.nvim` | Git signs, hunk actions, blame |
| `oil.nvim` | File explorer (edit filesystem as a buffer) |
| `grug-far.nvim` | Project-wide find and replace |
| `mini.surround` | Add/delete/replace surroundings |

## Keymaps

### General

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<Esc>` | Clear search highlight |
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `<leader>Q` | Force quit all |
| `<C-h/j/k/l>` | Window navigation |
| `<S-h>` / `<S-l>` | Previous/next buffer |
| `<leader>bd` | Delete buffer |
| `<A-j>` / `<A-k>` | Move line(s) up/down |
| `<C-d>` / `<C-u>` | Scroll down/up (centered) |
| `<leader>d` | Delete without yank |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>sx` | Close split |

### Find / Search

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fw` | Grep word under cursor |
| `<leader>/` | Search in current buffer |
| `<leader><leader>` | Switch buffer |
| `<leader>sh` | Help tags |
| `<leader>sk` | Keymaps |
| `<leader>sd` | Diagnostics |
| `<leader>ss` | Document symbols |
| `<leader>sS` | Workspace symbols |

### Find and Replace

| Key | Action |
|-----|--------|
| `<leader>sr` | Find and replace (grug-far) |
| `<leader>sR` | Replace word under cursor |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `gI` | Go to implementation |
| `gy` | Type definition |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `gK` | Signature help |
| `<C-k>` (insert) | Signature help |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename |
| `<leader>ch` | Toggle inlay hints |
| `<leader>cf` | Format buffer |
| `<leader>e` | Float diagnostic |
| `]q` / `[q` | Next/prev quickfix |

### File Explorer (oil.nvim)

| Key | Action |
|-----|--------|
| `-` or `<leader>n` | Open file explorer |
| `<CR>` | Open file/directory |
| `-` (in oil) | Go to parent directory |
| `<C-v>` | Open in vertical split |
| `<C-s>` | Open in horizontal split |
| `<C-p>` | Preview |
| `q` | Close |
| `g.` | Toggle hidden files |

### Git

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next/prev hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghS` | Stage buffer |
| `<leader>ghR` | Reset buffer |
| `<leader>ghu` | Undo stage |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame line |
| `<leader>ghd` | Diff this |
| `<leader>gc` | Git commits (telescope) |
| `<leader>gs` | Git status (telescope) |

### Surround (mini.surround)

| Key | Action |
|-----|--------|
| `gsa` | Add surrounding |
| `gsd` | Delete surrounding |
| `gsr` | Replace surrounding |

### Treesitter Text Objects

| Key | Action |
|-----|--------|
| `af` / `if` | Around/inside function |
| `ac` / `ic` | Around/inside class |
| `aa` / `ia` | Around/inside argument |
| `ai` / `ii` | Around/inside conditional |
| `al` / `il` | Around/inside loop |
| `]f` / `[f` | Next/prev function |
| `]c` / `[c` | Next/prev class |
| `<leader>a` | Swap argument forward |
| `<leader>A` | Swap argument backward |
| `<C-space>` | Incremental selection |
| `<BS>` | Shrink selection |

### Misc

| Key | Action |
|-----|--------|
| `<leader>l` | Lazy plugin manager |
| `<leader>cm` | Mason (tool installer) |
| `<leader>?` | Open this cheatsheet |

## LSP Servers

Configured out of the box (install via `:Mason`):

- `zls` -- Zig
- `gopls` -- Go
- `ts_ls` -- TypeScript/JavaScript
- `tailwindcss` -- Tailwind CSS
- `cssls` -- CSS/SCSS/Less
- `html` -- HTML
- `jsonls` -- JSON
- `clangd` -- C/C++
- `lua_ls` -- Lua

## Formatters

Configured in conform.nvim (install via `:Mason` or your package manager):

- `clang-format` -- C/C++
- `zig fmt` -- Zig
- `goimports` + `gofumpt` -- Go
- `prettierd` / `prettier` -- JS/TS/HTML/CSS/JSON/YAML/Markdown
- `stylua` -- Lua

Format-on-save is enabled. Skips files larger than 500KB.

## Stability Decisions

- **Auto-update checker disabled.** Plugins don't silently update. Run `:Lazy update` when you decide.
- **blink.cmp tracks releases** (`version = "*"`), not HEAD.
- **All language providers disabled** (python, ruby, perl, node). They throw warnings and slow startup.
- **Format-on-save skips large files** (>500KB).
- **No UI override plugins.** No noice.nvim, no dressing.nvim. Native Neovim UI is stable.
- **`splitkeep = "screen"`** prevents viewport jumping on splits.
- **Oil.nvim instead of neo-tree.** A buffer-based file explorer cannot crash your editor.

## First Launch

```bash
nvim
```

Lazy.nvim installs everything automatically. Then run `:Mason` to install language servers and formatters.
