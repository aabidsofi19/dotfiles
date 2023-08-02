require("colorscheme")
require("options")
require("plugins")
-- require("lsp")
require("keymaps").setup()
require("workspace")

if vim.g.neovide then
	-- Set transparency and background color (title bar color)

	vim.o.guifont = "Iosevka:h14"
	vim.g.neovide_transparency = 1
	-- vim.g.neovide_floating_blur = 2
	vim.g.transparency = 1
	vim.g.neovide_floating_blur_amount_x = 10
	vim.g.neovide_floating_blur_amount_y = 10
	vim.o.winblend = 60
	vim.o.pumblend = 60
	vim.g.neovide_refresh_rate = 60
end
