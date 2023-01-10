-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Tabbing
vim.opt.tabstop = 4

-- Scroll offset
vim.wo.scrolloff = 8

-- Display newlines + trailing spaces
vim.o.list = true
vim.opt.listchars:append "eol:↴"
vim.opt.listchars:append "trail:·"

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Don't store backups or swapfiles
vim.o.swapfile = false
vim.o.backup = false

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme dracula]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
