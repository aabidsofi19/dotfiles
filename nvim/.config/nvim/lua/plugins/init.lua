-- Plugin management via vim.pack (Neovim 0.12+)
local gh = function(x) return "https://github.com/" .. x end

-- Build hooks: run after install/update
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end

    -- fff.nvim: download or build binary
    if name == "fff.nvim" then
      if not ev.data.active then
        vim.cmd.packadd("fff.nvim")
      end
      require("fff.download").download_or_build_binary()
    end

    -- treesitter: run TSUpdate
    if name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

-- Register all plugins
vim.pack.add({
  -- UI
  gh("folke/tokyonight.nvim"),
  gh("nvim-tree/nvim-web-devicons"),

  -- File search (fff.nvim replaces telescope)
  gh("dmtrKovalenko/fff.nvim"),

  -- Treesitter
  gh("nvim-treesitter/nvim-treesitter"),
  gh("nvim-treesitter/nvim-treesitter-textobjects"),
  gh("windwp/nvim-ts-autotag"),

  -- Completion
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1.0") },

  -- Formatting
  gh("stevearc/conform.nvim"),

  -- Git
  gh("lewis6991/gitsigns.nvim"),

  -- Editor utilities
  gh("stevearc/oil.nvim"),
  gh("MagicDuck/grug-far.nvim"),
  gh("echasnovski/mini.surround"),
})

-- Disable useless built-in plugins
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1

-- Load plugin configurations (guarded: skip if plugin not yet installed)
local function load(mod)
  local ok, err = pcall(require, mod)
  if not ok then
    vim.notify("Skipping " .. mod .. " (not yet installed, restart after vim.pack finishes)\n" .. err, vim.log.levels.WARN)
  end
end

load("plugins.ui")
load("plugins.fff")
load("plugins.treesitter")
load("plugins.lsp")
load("plugins.cmp")
load("plugins.formatting")
load("plugins.git")
load("plugins.editor")
