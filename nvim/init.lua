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
require "configs.feline"
require "configs.notify"
require "configs.nvim-tree"
require "configs.telescope"
require "configs.todo-comments"
require "configs.treesitter"
require "configs.which-key"
require "lsp"

-- Color themes
vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_italics = true
vim.cmd [[colorscheme gruvbox]]
vim.cmd[[hi Normal ctermbg=none]]
vim.cmd[[hi NonText ctermbg=none]]
vim.cmd[[hi Normal guibg=000000]]
