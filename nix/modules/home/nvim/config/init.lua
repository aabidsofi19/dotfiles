local vim = vim

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.wrap = false
vim.o.swapfile = false
vim.o.signcolumn = 'yes'    -- Show sign column
vim.o.shiftwidth = 4        -- Indentation settings
vim.o.softtabstop = 4       -- Number of spaces a tab counts for
vim.o.expandtab = true      -- Use spaces instead of tabs
vim.o.autoindent = true     -- Auto-indent new lines
vim.o.smartindent = true    -- Smart indentation
vim.o.termguicolors = true  -- Enable 24-bit RGB colors
vim.o.winborder = "rounded" -- Use rounded borders for windows ( lsp hover, etc)

-- general  keybindings
vim.g.mapleader = ' '                                 -- Set leader key to space
vim.keymap.set('n', '<leader>w', ':write<CR>')        -- Save file with <leader>w
vim.keymap.set('n', '<leader>q', ':quit<CR>')         -- Quit with <leader>q
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format) -- Format code with <leader>lf

-- plugins
vim.pack.add({
    "https://github.com/rose-pine/neovim",      -- rose-pine theme
    "https://github.com/stevearc/oil.nvim",     -- File explorer
    "https://github.com/echasnovski/mini.pick", -- telescope alternative
    "https://github.com/neovim/nvim-lspconfig", -- LSP configuration
    "https://github.com/saghen/blink.cmp",      -- Auto-completion
    "https://github.com/github/copilot.vim",    -- github copilot
    "https://github.com/catgoose/nvim-colorizer.lua",              -- Colorizer for highlighting colors
    "https://github.com/lukas-reineke/indent-blankline.nvim", -- Indentation guides


})

-- enable plugins
require('colorizer').setup({})
require('indent_blankline').setup({ })

vim.cmd('colorscheme rose-pine') -- Set colorscheme to rose-pine
-- vim.cmd(':hi statusline guibg=NONE') -- Set statusline background to transparent



-- lsp

vim.lsp.enable({
    "lua_ls",        -- Lua language server
    "pyright",       -- Python language server
    "ts_ls",         -- TypeScript/JavaScript language server
    "gopls",         -- Go language server
    "clangd",        -- C/C++ language server
    "rust_analyzer", -- Rust language server
    "bashls",        -- Bash language server
    "html",          -- HTML language server
    "cssls",         -- CSS language server
    "jsonls",        -- JSON language server
    "yaml",          -- YAML language server
    "dockerls",      -- Docker language server
})


-- local lspconfig = require('lspconfig')
--
-- -- Basic tsserver setup
-- lspconfig.ts_ls.setup({
--   on_attach = function(client, bufnr)
--     -- Optional: Disable formatting so prettier or null-ls can handle it
--     client.server_capabilities.documentFormattingProvider = false
--     client.server_capabilities.documentRangeFormattingProvider = false
--
--     -- Keymaps (example)
--     local opts = { noremap = true, silent = true, buffer = bufnr }
--     vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--     vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--   end,
--   filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
--   cmd = { "typescript-language-server", "--stdio" }
-- })


-- plugin keymaps
require('oil').setup()
require('mini.pick').setup()


vim.keymap.set("n", "<leader>e", ":Oil<CR>")            -- Open file explorer with <leader>e
vim.keymap.set("n", "<leader>f", ":Pick files<CR>")     -- Open file picker with <leader>f
vim.keymap.set("n", "<leader>/", ":Pick grep_live<CR>") -- Open live grep with <leader>/
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")   -- Open buffer picker with <leader>b




-- lsp autocomplete
require('blink.cmp').setup({
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'enter' },

    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "lua" },

    providers = {
        "lsp", "path", "snippets", "buffers"
    },
})



-- lsp diagnostics
vim.diagnostic.config({
    virtual_text = false,     -- Show diagnostics inline
    signs = true,             -- Show signs in the sign column
    underline = true,         -- Underline diagnostics
    update_in_insert = false, -- Don't update diagnostics in insert mode
    severity_sort = true,     -- Sort diagnostics by severity
})

-- lsp keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })           -- Show diagnostics with <leader>ld
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename symbol' })                    -- Rename symbol with <leader>lr
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Show code actions' })           -- Show code actions with <leader>la
vim.keymap.set('n', '<leader>li', vim.lsp.buf.hover, { desc = 'Show hover information' })            -- Show hover information with <leader>li
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })      -- Go to next diagnostic with <leader>ld
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })  -- Go to previous diagnostic with <leader>lD
vim.keymap.set('n', '<leader>lI', vim.lsp.buf.incoming_calls, { desc = 'Show incoming calls' })      -- Show incoming calls with <leader>lI
vim.keymap.set('n', '<leader>lO', vim.lsp.buf.outgoing_calls, { desc = 'Show outgoing calls' })      -- Show outgoing calls with <leader>lO
vim.keymap.set('n', '<leader>lK', vim.lsp.buf.signature_help, { desc = 'Show signature help' })      -- Show signature help with <leader>lK
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format code' })                      -- Format code with <leader>lF
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol, { desc = 'Show document symbols' })   -- Show document symbols with <leader>lS
vim.keymap.set('n', '<leader>lw', vim.lsp.buf.workspace_symbol, { desc = 'Show workspace symbols' }) -- Show workspace symbols with <leader>lW
vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, { desc = 'Go to declaration' })                   -- Go to declaration with <leader>lC
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })           -- Go to type definition with <leader>lT
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })                      -- Show references with <leader>lR
vim.keymap.set('n', '<leader>lX', vim.lsp.buf.document_highlight, { desc = 'Highlight document' })   -- Highlight document with <leader>lX

-- workspace diagnostics
vim.keymap.set('n', '<leader>lD', function()
    vim.diagnostic.setloclist({ open = true })       -- Open diagnostics in location list
end, { desc = 'Open diagnostics in location list' }) -- Open diagnostics with <leader>lD
