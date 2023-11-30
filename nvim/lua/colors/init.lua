-- Colorschemes
require("bamboo").load()

local scheme = "Bamboo"
-- local theme = "dark"

vim.cmd("colorscheme " .. scheme)

vim.o.background = theme

-- Highlight goodies
vim.cmd([[hi Normal ctermbg=none]])
vim.cmd([[hi NonText ctermbg=none]])
vim.cmd([[hi Normal guibg=000000]])
