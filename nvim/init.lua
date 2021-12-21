require('options')
require('plugins')
require('mappings')
require('configs.lualine')
require('lsp')

-- ****************************
-- General Settings
-- ****************************
local global = {
  mapleader = ' ',
  gruvbox_italic_functions = true,
  gruvbox_transparent = true,
  gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" },
  gruvbox_colors = { hint = "orange", error = "#ff0000" },
  --ale_fixers = { 
    --javascript = { 'eslint', 'prettier' },
    --css = { 'eslint' },
    --json = { 'prettier' } 
  --},
  --ale_fix_on_save = 1,
  --ale_sign_error = '',
  --ale_sign_warning = '--',
  --UltiSnipsSnippetDirectories = { os.getenv('HOME') .. '/dotfiles/UltiSnips' },
}

for k, v in pairs(global) do
  vim.g[k] = v
end

vim.cmd[[colorscheme gruvbox-flat]]
