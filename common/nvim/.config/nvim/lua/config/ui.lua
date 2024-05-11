-- UI
function devions()
	require("nvim-web-devicons").setup({
		-- your personnal icons can go here (to override)
		-- you can specify color or cterm_color instead of specifying both of them
		-- DevIcon will be appended to `name`
		override = {
			zsh = {
				icon = "",
				color = "#428850",
				cterm_color = "65",
				name = "Zsh",
			},
		},
		-- globally enable different highlight colors per icon (default to true)
		-- if set to false all icons will have the default icon's color
		color_icons = true,
		-- globally enable default icons (default to false)
		-- will get overriden by `get_icons` option
		default = true,
		-- globally enable "strict" selection of icons - icon will be looked up in
		-- different tables, first by filename, and if not found by extension; this
		-- prevents cases when file doesn't have any extension but still gets some icon
		-- because its name happened to match some extension (default to false)
		strict = true,
		-- same as `override` but specifically for overrides by filename
		-- takes effect when `strict` is true
		override_by_filename = {
			[".gitignore"] = {
				icon = "",
				color = "#f1502f",
				name = "Gitignore",
			},
		},
		-- same as `override` but specifically for overrides by extension
		-- takes effect when `strict` is true
		override_by_extension = {
			["log"] = {
				icon = "",
				color = "#81e043",
				name = "Log",
			},
		},
	})
end

return {
	{
		"nvim-tree/nvim-web-devicons",
		config = devions,
	},

	{
		"nvim-tree/nvim-tree.lua",
		config = [[require('config.nvim-tree')]],
	},

	{
		"nvim-lualine/lualine.nvim",
		-- event = "ColorScheme",
		config = [[require('config.lualine')]],
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	},

	{
		"b0o/incline.nvim",
		config = function()
			require("incline").setup({})
		end,
	},

	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	config = function()
	-- 		require("ibl").setup()
	-- 	end,
	-- },

	{
		"akinsho/bufferline.nvim",
		-- event = "ColorScheme",
		config = function()
			require("bufferline").setup({
				options = {},
			})
			vim.g.transparent_groups = vim.list_extend(
				vim.g.transparent_groups or {},
				vim.tbl_map(function(v)
					return v.hl_group
				end, vim.tbl_values(require("bufferline.config").highlights))
			)
		end,
		requires = "nvim-tree/nvim-web-devicons",
	},

	{
		"folke/noice.nvim",
		-- disable = vim.g.neovide,
		-- cond = function()
		-- return not vim.g.neovide
		-- end,
		config = function()
			require("config.noice")
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup()
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	--- GREETER / DASHBAORD
	{
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
}
