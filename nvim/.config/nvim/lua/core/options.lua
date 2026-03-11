local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.cursorline = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.pumheight = 10
opt.showmode = false
opt.laststatus = 0
opt.cmdheight = 1
opt.winminwidth = 5
opt.showtabline = 0
opt.fillchars = { eob = " ", stl = " ", stlnc = " " }
opt.statusline = "%f %m"
opt.list = false

-- Splits
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- Files & undo
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.writebackup = false

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300
opt.redrawtime = 1500

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmode = "longest:full,full"

-- Misc
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.wrap = false
opt.linebreak = true
opt.confirm = true
opt.iskeyword:append("-")
opt.shortmess:append("WcCI")
opt.smoothscroll = true
opt.jumpoptions = "view"
opt.virtualedit = "block"

-- Grep - use ripgrep
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case --hidden"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Folding (treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldtext = ""

-- Kill useless providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Filetype indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact", "json", "jsonc", "lua", "html", "css", "scss" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})
