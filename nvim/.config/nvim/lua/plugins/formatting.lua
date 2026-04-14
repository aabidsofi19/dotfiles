-- conform.nvim: formatting
local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    zig = { "zigfmt" },
    go = { "goimports", "gofumpt" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    scss = { "prettierd", "prettier", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    haskell = { "ormolu" },
    lua = { "stylua" },
  },
  format_on_save = function(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local ok, stats = pcall(vim.uv.fs_stat, bufname)
    if ok and stats and stats.size > 500 * 1024 then
      return
    end
    return { timeout_ms = 3000, lsp_format = "fallback" }
  end,
  formatters = {
    zigfmt = {
      command = "zig",
      args = { "fmt", "--stdin" },
      stdin = true,
    },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
