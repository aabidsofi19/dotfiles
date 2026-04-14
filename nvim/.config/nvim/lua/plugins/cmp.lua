-- blink.cmp: completion
require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },

  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
  },

  completion = {
    accept = { auto_brackets = { enabled = true } },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "rounded" },
    },
    menu = {
      border = "rounded",
      draw = {
        treesitter = { "lsp" },
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind" },
        },
      },
    },
    list = {
      selection = { preselect = true, auto_insert = false },
    },
    ghost_text = { enabled = true },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  signature = {
    enabled = true,
    window = { border = "rounded" },
  },
})
