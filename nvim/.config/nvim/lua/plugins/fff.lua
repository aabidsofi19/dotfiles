-- fff.nvim: file search + live grep (replaces telescope)
local fff = require("fff")

vim.g.fff = {
  lazy_sync = true,
}

fff.setup({
  prompt = "> ",
  title = "Files",
  max_results = 100,
  layout = {
    height = 0.8,
    width = 0.87,
    prompt_position = "bottom",
    preview_position = "right",
    preview_size = 0.55,
  },
  preview = {
    enabled = true,
    line_numbers = false,
  },
  keymaps = {
    close = "<Esc>",
    select = "<CR>",
    select_split = "<C-s>",
    select_vsplit = "<C-v>",
    select_tab = "<C-t>",
    move_up = { "<Up>", "<C-k>" },
    move_down = { "<Down>", "<C-j>" },
    preview_scroll_up = "<C-u>",
    preview_scroll_down = "<C-d>",
    toggle_select = "<Tab>",
    send_to_quickfix = "<C-q>",
  },
  frecency = { enabled = true },
  history = { enabled = true },
  grep = {
    smart_case = true,
    modes = { "plain", "regex", "fuzzy" },
  },
})

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>ff", function() fff.find_files() end, { desc = "Find files" })
map("n", "<leader>fg", function() fff.live_grep() end, { desc = "Live grep" })
map("n", "<leader>fw", function()
  fff.live_grep({ query = vim.fn.expand("<cword>") })
end, { desc = "Grep word under cursor" })
map("n", "<leader>fz", function()
  fff.live_grep({ grep = { modes = { "fuzzy", "plain" } } })
end, { desc = "Fuzzy grep" })

-- Short aliases (fff.nvim style)
map("n", "ff", function() fff.find_files() end, { desc = "Find files" })
map("n", "fg", function() fff.live_grep() end, { desc = "Live grep" })
