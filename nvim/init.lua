require "global"
require "options"
require "mappings"
require "plugins"
-- Plugin configuration
require "configs.autopairs"
require "configs.cmp"
require "configs.colorizer"
require "configs.dap"
require "configs.floatterm"
require "configs.gitsigns"
--require "configs.feline"
require "configs.lualine"
require "configs.notify"
require "configs.nvim-tree"
require "configs.telescope"
require "configs.todo-comments"
require "configs.treesitter"
require "configs.which-key"
require "lsp"
-- Color themes
require "colors.catppuccin"

vim.cmd [[colorscheme catppuccin]]
