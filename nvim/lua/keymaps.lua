local wk = require("which-key")
local telescope_builtins = require("telescope.builtin")

vim.o.timeout = true
vim.o.timeoutlen = 300
wk.setup()

local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

local M = {}

-- define common options
local function vim_setup()
	vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

	-----------------
	-- Normal mode --
	-----------------

	-- Better window navigation
	vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
	vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
	vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
	vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

	-- Resize with arrows
	-- delta: 2 lines
	vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
	vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
	vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
	vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

	----Terminal
	--vim.keymap.set('n', '<C-t>', '<cmd> ToggleTerm direction=horizontal size=10 <CR>', opts)
	function _G.set_terminal_keymaps()
		local opts = { buffer = 0 }
		vim.keymap.set("t", "<C-t>", [[<cmd> ToggleTerm <CR>]], opts)
		vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
		vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
	end

	-- if you only want these mappings for toggle term use term://*toggleterm#* instead
	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

	-----------------
	-- Visual mode --
	-----------------

	-- Hint: start visual mode with the same area as the previous area and the same mode
	vim.keymap.set("v", "<", "<gv", opts)
	vim.keymap.set("v", ">", ">gv", opts)
end

M.setup = function()
	vim_setup()

	-- NORMAL MODE
	wk.register({

		f = {
			name = "+file",
			f = { telescope_builtins.find_files, "Find files" },
			g = { telescope_builtins.live_grep, "Live Grep" },
			b = { telescope_builtins.buffers, "Search Buffers" },
			r = { telescope_builtins.oldfiles, "Recent Files" },
		},

		t = {
			name = "+terminal",
			t = { "<cmd> ToggleTerm direction=horizontal size=10 <cr>", "Bottom Terminal" },
			f = { "<cmd> ToggleTerm direction=float size=40 <cr>", "Bottom Terminal" },
		},

		-- Comments
		c = { "<Plug>(comment_toggle_linewise_current)", "Comment Toggle" },

		x = {
			name = "+diagnostics",
			x = { "<cmd>TroubleToggle<cr>", "Toggle Diagonistics" },
			w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagonistics" },
			d = { "<cmd>TroubleToggle document_diagnostics <cr>", "Document Diagonistics" },
			l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
			q = { "<cmd>TroubleToggle quickfix<cr>", "Workspace Quickfix" },
			r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
		},

		-- File Explorer
		e = {
			name = "File Explorer",
			f = { "<cmd> NvimTreeFocus <CR>", "Focus" },
			e = { "<cmd> NvimTreeToggle <CR>", "Toggle" },
		},

		--Workspace
		w = {
			name = "+workspace",
			a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
			r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
			l = {
				function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,
				"List workspace folders",
			},
		},
	}, { prefix = "<leader>" })

	wk.register({

		--lsp
		K = { vim.lsp.buf.hover, "Show hover information" },
		["<C-k>"] = { vim.lsp.buf.signature_help, "Show function signature help" },
		--diagnostic
		["[d"] = { "vim.diagnostic.goto_prev", "Prev Diagonistic" },
		["]d"] = { "vim.diagnostic.goto_prev", "Next Diagonistic" },
	})

	-- VISUAL MODE
	wk.register({

		--comments
		c = { "<Plug>(comment_toggle_linewise_visual)", "Comment Toggle" },

		--Refactoring
		r = {
			name = "+Refactoring",

			r = {
				":lua require('refactoring').select_refactor()<CR>",
				"Refactor Menu",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
	}, { prefix = "<leader>", mode = "x" })
end

M.load_lsp = function(bufnr)
	wk.register({
		--LSP
		l = {
			name = "+lsp",
			r = { vim.lsp.buf.rename, "Rename symbol" },
			a = { vim.lsp.buf.code_action, "Code action" },
			f = {
				function()
					vim.lsp.buf.format({ async = true })
				end,
				"Format code",
			},
		},
		g = {
			name = "+goto",
			d = { vim.lsp.buf.type_definition, "Go to type definition" },
			D = { vim.lsp.buf.declaration, "Go to declaration" },
			i = { vim.lsp.buf.implementation, "Go to implementation" },
			r = { vim.lsp.buf.references, "Find references" },
		},
	}, { prefix = "<leader>", noremap = true, silent = true, buffer = bufnr, mode = "n" })
end

M.load_rust_tools = function(rt, bufnr)
	wk.register({
		--lsp
		K = { rt.hover_actions.hover_actions, "Show hover information" },
		["<leader>la"] = { rt.code_action_group.code_action_group, "Code Action" },
	}, { noremap = true, silent = true, buffer = bufnr, mode = "n" })
end

return M
