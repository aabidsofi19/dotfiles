-- Leader key before anything
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Plugins
require("plugins")
