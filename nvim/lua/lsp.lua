local present, lspconfig = pcall(require, "lspconfig")

if not present then
	vim.notify("Plugin LSP Config not Found")
end

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local servers = {
	-- rome = {},
	pyright = {},
	tsserver = {},
	cssls = {},
	html = {},
	jsonls = {},
	gopls = {},
	-- rust_analyzer = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

local on_attach = function(client, bufnr)
	local keymap = require("keymaps")
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	keymap.load_lsp(bufnr)
end

--LSP Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- MASON-LSPCONFIG.NVIM
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

--RUST TOOLS

local rt = require("rust-tools")

rt.setup({
	server = {
		on_attach = function(_, bufnr)
			require("keymaps").load_lsp(bufnr)
			require("keymaps").load_rust_tools(rt, bufnr)
		end,
		capabilities = capabilities,
	},
})

-- NULL-LS.NVIM
-- LSP formatting filter
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- Ignore formatting from these LSPs
			local lsp_formatting_denylist = {
				eslint = true,
				lemminx = true,
				lua_ls = true,
			}
			if lsp_formatting_denylist[client.name] then
				return false
			end
			return true
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local linters = require("null-ls").builtins.diagnostics
local formatters = require("null-ls").builtins.formatting
local null_ls = require("null-ls")
local workspace_config = require("workspace").load_project_config()
local workspace_sources = nil

if workspace_config then
	workspace_sources = workspace_config.null_ls_sources(null_ls)
else
	workspace_sources = {

		-- formatting
		formatters.prettierd,
		formatters.black,
		formatters.eslint_d,
		formatters.stylua,

		--linters
		linters.eslint_d,
		linters.ruff,

		-- linters.rome,
		linters.mypy,
	}
end

require("null-ls").setup({
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,

	sources = workspace_sources,
})

require("crates").setup({
	null_ls = {
		enabled = true,
		name = "crates.nvim",
	},
})
