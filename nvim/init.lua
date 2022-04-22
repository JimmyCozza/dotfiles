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



--vim.opt.background = "dark"
vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_italics = true
--vim.g.gruvbox_transparent_bg = true
vim.cmd [[colorscheme gruvbox]]
vim.cmd[[highlight Normal ctermbg=none]]
vim.cmd[[highlight NonText ctermbg=none]]
vim.cmd[[highlight normal guibg=000000]]
