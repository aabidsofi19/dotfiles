return {
  -- Theme: tokyonight night -- dark, clean, matches the screenshot
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
      on_colors = function(colors)
        -- Darken the background slightly for that deep look
        colors.bg = "#16161e"
        colors.bg_dark = "#101014"
      end,
      on_highlights = function(hl, c)
        -- Clean line numbers: muted, not distracting
        hl.LineNr = { fg = c.dark5 }
        hl.CursorLineNr = { fg = c.blue, bold = true }
        -- No sign column background
        hl.SignColumn = { bg = "NONE" }
        -- Clean statusline: just filename at the bottom
        hl.StatusLine = { fg = c.dark5, bg = c.bg }
        hl.StatusLineNC = { fg = c.dark3, bg = c.bg }
      end,
      sidebars = { "qf", "help", "terminal" },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Icons (dependency for telescope)
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
