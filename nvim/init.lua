require('plugins')
require('mappings')

-- ****************************
-- Plugin Configurations
-- ****************************
require('configs.which-key')
require('configs.telescope')
require('configs.floatterm')

-- ****************************
-- General Settings
-- ****************************
vim.g.mapleader      = ' '
vim.opt.number       = true
vim.opt.wrap         = false
vim.opt.tabstop      = 2
vim.opt.softtabstop  = 2
vim.opt.shiftwidth   = 2
vim.opt.hidden       = true
vim.opt.expandtab    = true
vim.opt.ignorecase   = true
vim.opt.smartcase    = true
vim.opt.clipboard    = 'unnamedplus'
vim.opt.cursorline   = true
vim.opt.inccommand   = 'nosplit'
vim.opt.mouse        = 'a'
vim.opt.swapfile     = false
vim.opt.undofile     = true
vim.opt.completeopt  = 'menu,noselect'
vim.opt.splitbelow   = true
vim.opt.splitright   = true


-- ****************************
-- Visual Settings
-- ****************************
vim.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = true
require('nord').set()
