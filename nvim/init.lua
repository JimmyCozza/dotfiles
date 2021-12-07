require('plugins')
require('mappings')
require('configs.lualine')

-- ****************************
-- General Settings
-- ****************************
vim.g.mapleader       = ' '
vim.opt.number        = true
vim.opt.wrap          = false
vim.opt.tabstop       = 2
vim.opt.softtabstop   = 2
vim.opt.shiftwidth    = 2
vim.opt.hidden        = true
vim.opt.expandtab     = true
vim.opt.ignorecase    = true
vim.opt.smartcase     = true
vim.opt.clipboard     = 'unnamedplus'
vim.opt.cursorline    = true
vim.opt.inccommand    = 'nosplit'
vim.opt.mouse         = 'a'
vim.opt.swapfile      = false
vim.opt.undofile      = true
vim.opt.completeopt   = 'menu,noselect'
vim.opt.splitbelow    = true
vim.opt.splitright    = true
vim.opt.termguicolors = true
vim.opt.scrolloff     = 8


-- ****************************
-- Visual Settings
-- ****************************

vim.g.gruvbox_italic_functions = true
vim.g.gruvbox_transparent = true
vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.gruvbox_colors = { hint = "orange", error = "#ff0000" }
vim.cmd[[colorscheme gruvbox-flat]]


-- ****************************
-- ALE Settings
-- ****************************
vim.g.ale_fixers = { 
  javascript = { 'eslint', 'prettier' },
  css = { 'eslint' },
  json = { 'prettier' } 
}
vim.g.ale_fix_on_save = 1
vim.g.ale_sign_error = ''
vim.g.ale_sign_warning = '--'

-- ****************************
-- Snippets
-- ****************************
vim.g.UltiSnipsSnippetDirectories = { os.getenv('HOME') .. '/dotfiles/UltiSnips' }
