require("colorscheme")
require("options")
require("plugins")
require("lsp")
require("keymaps").setup()
require("workspace")

vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap('i', '<C-X>', 'copilot#Accept("<CR>")', {expr=true, silent=true,script=true})

if vim.g.neovide then
	-- Set transparency and background color (title bar color)
	vim.o.guifont = "Iosevka:h16"
	vim.g.neovide_transparency = 0.9
	vim.g.neovide_floating_blur = 1
	-- vim.g.transparency = 0.6
	vim.g.neovide_floating_blur_amount_x = 10
	vim.g.neovide_floating_blur_amount_y = 10
	-- vim.o.winblend = 60
	-- vim.o.pumblend = 60
	vim.g.neovide_refresh_rate = 60
end

