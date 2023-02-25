-- [[ Setting options ]]
-- See `:help vim.opt`

-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.cursorline = true

vim.opt.colorcolumn = "80"

-- Tabbing, indenting etc.
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- we have a statusline
vim.opt.showmode = false

-- Scroll offset
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Display newlines + trailing spaces
vim.opt.list = true
vim.opt.listchars:append 'eol:¬'
vim.opt.listchars:append 'trail:·'
vim.opt.listchars:append "tab:→ "

-- Enable mouse mode
vim.opt.mouse = 'a'

-- disable wrap
vim.opt.wrap = true

-- more logical splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Don't store backups or swapfiles
vim.opt.swapfile = false
vim.opt.backup = false

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.opt.termguicolors = true
vim.cmd [[colorscheme melange]]

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
