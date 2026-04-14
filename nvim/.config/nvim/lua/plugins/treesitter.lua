-- Treesitter: install parsers, highlight/indent are built-in
-- The plugin only handles parser installation now; highlight + indent
-- are enabled via vim.treesitter (configured in core/options.lua).

require("nvim-treesitter").setup({})

-- Install parsers
local parsers = {
  "c", "cpp", "zig", "haskell",
  "go", "gomod", "gosum", "gowork",
  "javascript", "typescript", "tsx",
  "html", "css", "json",
  "lua", "luadoc", "vim", "vimdoc",
  "bash", "toml", "yaml", "dockerfile",
  "regex", "markdown", "markdown_inline",
  "gitcommit", "gitignore", "diff", "query",
}

-- Auto-install missing parsers
local installed = require("nvim-treesitter").get_installed()
local installed_set = {}
for _, p in ipairs(installed) do
  installed_set[p] = true
end
for _, p in ipairs(parsers) do
  if not installed_set[p] then
    require("nvim-treesitter").install({ p })
  end
end

-- Textobjects
local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

require("nvim-treesitter-textobjects").setup({
  select = { lookahead = true },
  move = { set_jumps = true },
})

-- Select keymaps
local sel = function(capture)
  return function() select.select_textobject(capture, "textobjects") end
end

vim.keymap.set({ "x", "o" }, "af", sel("@function.outer"), { desc = "Around function" })
vim.keymap.set({ "x", "o" }, "if", sel("@function.inner"), { desc = "Inside function" })
vim.keymap.set({ "x", "o" }, "ac", sel("@class.outer"), { desc = "Around class" })
vim.keymap.set({ "x", "o" }, "ic", sel("@class.inner"), { desc = "Inside class" })
vim.keymap.set({ "x", "o" }, "aa", sel("@parameter.outer"), { desc = "Around argument" })
vim.keymap.set({ "x", "o" }, "ia", sel("@parameter.inner"), { desc = "Inside argument" })
vim.keymap.set({ "x", "o" }, "ai", sel("@conditional.outer"), { desc = "Around conditional" })
vim.keymap.set({ "x", "o" }, "ii", sel("@conditional.inner"), { desc = "Inside conditional" })
vim.keymap.set({ "x", "o" }, "al", sel("@loop.outer"), { desc = "Around loop" })
vim.keymap.set({ "x", "o" }, "il", sel("@loop.inner"), { desc = "Inside loop" })

-- Move keymaps
vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
vim.keymap.set({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end, { desc = "Next argument" })
vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
vim.keymap.set({ "n", "x", "o" }, "]C", function() move.goto_next_end("@class.outer", "textobjects") end, { desc = "Next class end" })
vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function start" })
vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class start" })
vim.keymap.set({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end, { desc = "Prev argument" })
vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Prev function end" })
vim.keymap.set({ "n", "x", "o" }, "[C", function() move.goto_previous_end("@class.outer", "textobjects") end, { desc = "Prev class end" })

-- Swap keymaps
vim.keymap.set("n", "<leader>a", function() swap.swap_next("@parameter.inner") end, { desc = "Swap next argument" })
vim.keymap.set("n", "<leader>A", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap prev argument" })

-- Auto-close/rename HTML tags (JSX/TSX)
require("nvim-ts-autotag").setup({})
