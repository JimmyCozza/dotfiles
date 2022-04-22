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

vim.g.gruvbox_contrast = true
vim.g.gruvbox_borders = false
vim.g.gruvbox_disable_background = true
vim.g.gruvbox_italic = false
require("gruvbox").set()
