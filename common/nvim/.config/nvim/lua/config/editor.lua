-- Plugins Related To editor stuff like LSP , Treesitter , Debugger

return {

	-- Color Schemes
	"folke/tokyonight.nvim",
	"nyoom-engineering/oxocarbon.nvim",
	"rebelot/kanagawa.nvim",
	"EdenEast/nightfox.nvim",
	{
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("rose-pine").setup({ --- @usage 'auto'|'main'|'moon'|'dawn'
				variant = "moon",
				--- @usage 'main'|'moon'|'dawn'
				dark_variant = "moon",
				disable_background = false,
				disable_float_background = false,
			})
		end,
	},
	{ "catppuccin/nvim", as = "catppuccin", config = [[require("config.catppuccin")]] },
	-- Comments
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({})
		end,
	},

	-- for auto closing quotes and bracket pairs.
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = [[require('config.treesitter')]],
	},
	"nvim-treesitter/nvim-treesitter-context",
	"p00f/nvim-ts-rainbow",
    -- Copilot 
    { "github/copilot.vim"},
    ----------------------------------------
	-- LSP Plugins
	-- ------------------------------------
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
	}, -- Null ls is used for code formatting and pylint analysis
	{ "simrat39/rust-tools.nvim" },
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
			})

			require("lsp_lines").setup()
			vim.keymap.set("", "<leader>ll", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
		end,
	},
	----------------------------
	--auto-completion
	----------------------------

	{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
	{ "hrsh7th/cmp-buffer", after = "nvim-cmp" }, -- buffer auto-completion
	{ "hrsh7th/cmp-path", after = "nvim-cmp" }, -- path auto-completion
	{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" }, -- cmdline auto-completion
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	{ "onsails/lspkind.nvim" },
	{
		"hrsh7th/nvim-cmp",
		config = [[require('config.nvim-cmp')]],
	},

	--- GIT
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.git")
		end,
	},
    {
        "akinsho/git-conflict.nvim", tag = "*",
        config = function()
            require('git-conflict').setup()
        end
    },

	--- Terminals
	{
		"akinsho/toggleterm.nvim",
		-- event = "ColorScheme",
		config = function()
			local highlights = require("rose-pine.plugins.toggleterm")
			require("toggleterm").setup({ highlights = highlights })
		end,
	},
	--  TelesCope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
		config = [[require('config.telescope')]],
	},

	-- Diagonistics And Refactoring
	"folke/trouble.nvim",

	---
	{
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("refactoring").setup({})
		end,
	},

	-- Editor Utilities
	{
		"mrjones2014/legendary.nvim",
		config = function()
			require("legendary").setup()
		end,
	},

	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({})
		end,
	},

	-- Rust
	{
		"saecki/crates.nvim",
		tag = "v0.3.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
}
