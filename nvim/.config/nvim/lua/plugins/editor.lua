-- Oil: file explorer as a buffer
require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name)
      return name == ".git" or name == "node_modules" or name == "zig-cache" or name == "zig-out"
    end,
  },
  float = {
    padding = 2,
    max_width = 120,
    max_height = 40,
    border = "rounded",
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["q"] = "actions.close",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
  },
  use_default_keymaps = false,
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>n", "<cmd>Oil<CR>", { desc = "File explorer" })

-- Grug-far: find and replace across files
require("grug-far").setup({
  headerMaxWidth = 80,
})

vim.keymap.set("n", "<leader>sr", function()
  require("grug-far").open({ transient = true })
end, { desc = "Find and Replace" })

vim.keymap.set("n", "<leader>sR", function()
  require("grug-far").open({ transient = true, prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Replace word under cursor" })

-- Mini.surround
require("mini.surround").setup({
  mappings = {
    add = "gsa",
    delete = "gsd",
    find = "gsf",
    find_left = "gsF",
    highlight = "gsh",
    replace = "gsr",
    update_n_lines = "gsn",
  },
})
