local opts = { noremap = true, silent = true } 
local h = require("helpers")
local map = h.map
local leaderMap = h.leaderMap

-- ****************************
-- General
-- ****************************
map("i", "jk", "<Esc>:w<cr>", opts)
map("v", "dp", "_dP", opts)
map("t", "<esc>", "<C-\\><C-n>", { silent = true })
map("n", "<Right>", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
map("n", "<Left>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)

-- ****************************
-- Search
-- ****************************
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "<C-b>", ":NvimTreeToggle<cr>", opts)

-- ****************************
-- Splits
-- ****************************
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- ****************************
-- Completion
-- ****************************
map("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

-- ****************************
-- Other Stuff
-- ****************************
-- helpers for adding semicolon or comma and removing always at end of the current line
map("n", ";;", "m`A;<Esc>`", opts)
map("n", ",,", "m`A,<Esc>`", opts)
map("n", "::", "m`$x<Esc>`", opts)

-- Move lines up or down
map("i", "<A-j>", "<Esc>:move .+1<cr>==gi", opts)
map("i", "<A-k>", "<Esc>:move .-2<cr>==gi", opts)
map("v", "<A-j>", "<Esc>:move .+1<cr>gv-gv", opts)
map("v", "<A-k>", "<Esc>:move .-2<cr>gv-gv", opts)

--Quickfix List stuff
map("n", "<UP>", "<cmd>cprevious<cr>", opts)
map("n", "<DOWN>", "<cmd>cnext<cr>", opts)

-- ****************************
-- Navigation/Search
-- ****************************
-- Quick File edits
leaderMap("ea", ":e $HOME/.config/awesome/rc.lua")
leaderMap("ep", ":e $HOME/.config/nvim/lua/plugins.lua")
leaderMap("et", ":e $HOME/dotfiles/wezterm/wezterm.lua")
leaderMap("ev", ":e $HOME/.config/nvim/init.lua")
leaderMap("ez", ":e $HOME/dotfiles/zshrc")

--Telescope
leaderMap("/", "lua require('telescope.builtin').live_grep({additional_args = function() return {'--glob=!package-lock.json'} end})")
leaderMap("pf", "Telescope find_files")
leaderMap("hh", "Telescope help_tags")
leaderMap("hm", "Telescope man_pages")

-- File Tree



leaderMap("sc", "nohlsearch")

