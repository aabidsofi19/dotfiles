-- LSP: pure built-in vim.lsp.config + vim.lsp.enable (no plugins)

-- Diagnostics
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = true },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
  virtual_text = { spacing = 4, prefix = ">" },
})

-- LSP keymaps on attach (all built-in vim.lsp.buf)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
  callback = function(event)
    local function map(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "Definition")
    map("gr", vim.lsp.buf.references, "References")
    map("gI", vim.lsp.buf.implementation, "Implementation")
    map("gy", vim.lsp.buf.type_definition, "Type Definition")
    map("gD", vim.lsp.buf.declaration, "Declaration")
    map("K", vim.lsp.buf.hover, "Hover")
    map("gK", vim.lsp.buf.signature_help, "Signature Help")
    map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
    map("<leader>cr", vim.lsp.buf.rename, "Rename")
    map("<leader>ch", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
    end, "Toggle Inlay Hints")
  end,
})

-- Capabilities (integrate with blink.cmp if available)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

-- Server configs
vim.lsp.config("zls", {
  cmd = { "zls" },
  filetypes = { "zig", "zon" },
  root_markers = { "build.zig", "build.zig.zon", ".git" },
  capabilities = capabilities,
  settings = {
    zls = { enable_build_on_save = true, build_on_save_step = "check" },
  },
})

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.mod", "go.work", ".git" },
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-node_modules", "-vendor" },
      semanticTokens = true,
    },
  },
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

vim.lsp.config("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", "tailwind.config.mjs" },
  capabilities = capabilities,
})

vim.lsp.config("cssls", {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("html", {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  root_markers = { "package.json", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("jsonls", {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  capabilities = capabilities,
  settings = { json = { validate = { enable = true } } },
})

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", "CMakeLists.txt", "Makefile", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
      completion = { callSnippet = "Replace" },
      diagnostics = { disable = { "missing-fields" } },
      hint = { enable = true },
    },
  },
})

vim.lsp.config("hls", {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml", ".git" },
  capabilities = capabilities,
  settings = {
    haskell = {
      formattingProvider = "ormolu",
      plugin = {
        rename = { config = { crossModule = true } },
      },
    },
  },
})

vim.lsp.enable({
  "clangd", "zls", "gopls", "ts_ls",
  "tailwindcss", "cssls", "html", "jsonls", "lua_ls",
  "hls",
})
