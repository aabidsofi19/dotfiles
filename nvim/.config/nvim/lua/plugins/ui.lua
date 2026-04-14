-- Tokyonight: dark, clean theme
require("tokyonight").setup({
  style = "night",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
  },
  on_colors = function(colors)
    colors.bg = "#16161e"
    colors.bg_dark = "#101014"
  end,
  on_highlights = function(hl, c)
    hl.LineNr = { fg = c.dark5 }
    hl.CursorLineNr = { fg = c.blue, bold = true }
    hl.SignColumn = { bg = "NONE" }
    hl.StatusLine = { fg = c.dark5, bg = c.bg }
    hl.StatusLineNC = { fg = c.dark3, bg = c.bg }
  end,
  sidebars = { "qf", "help", "terminal" },
})
vim.cmd.colorscheme("tokyonight")

-- Devicons (loaded by vim.pack, no extra config needed)
require("nvim-web-devicons").setup()
