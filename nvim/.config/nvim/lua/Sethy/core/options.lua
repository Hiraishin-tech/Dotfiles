vim.cmd("let g:netrw_banner = 0")

-- vim.opt.guicursor = "" -- For block cursor
-- line numbers:
vim.opt.nu = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- backup and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true -- can undo changes even after restarting neovim

vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true -- when search includes the capital letter, it will take it into consideration

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.scrolloff = 8 -- padding for scrolling
vim.opt.signcolumn = "yes" -- can show git diagnostics and other things

vim.opt.backspace = {"start", "eol", "indent" }

vim.opt.splitright = true -- vertical split
vim.opt.splitbelow = true -- horizontal split

-- optional:
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.clipboard:append("unnamedplus") -- for copying between neovim and different apps
vim.opt.hlsearch = true -- when searching for something in neovim it will also hightlight the text

vim.opt.mouse = "a" -- mouse support
vim.g.editorconfig = true -- consistent coding style accross editors
