-- define your colorscheme here

--The pcall here refers to a protected call in Lua, which will return a boolean value
--to indicate its successful execution(a similar approach can be found in Go with the use of err).
--By using pcall instead of vim.cmd('colorscheme monokai_pro'),
--we can avoid some annoying error messages in case the colorscheme is not installed2

--colorschemes tokyonight , oxocarbon , kanagawa , nightfox , carbonfox , duskfox , nordfox
-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
local colorscheme = "tokyonight"

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
