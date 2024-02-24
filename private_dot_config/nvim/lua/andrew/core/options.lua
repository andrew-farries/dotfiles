-- Enable line numbers
vim.opt.number = true

-- Tab related settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Enable auto indentation
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Enable smart indenting
vim.opt.breakindent = true
vim.opt.linebreak = true

-- Enable incremental searching
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable the mouse
vim.opt.mouse = ""

-- Enable ignorecase + smartcase for better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease updatetime to 50ms
vim.opt.updatetime = 50

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable the sign column and share it with the number column
vim.opt.signcolumn = "number"

-- Enable access to System Clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 8

-- Ignore case in the wildmenu
vim.opt.wildignorecase = true

-- No swap files or backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
