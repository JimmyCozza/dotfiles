local opts = { noremap = true, silent = true }
local map = vim.keymap.set
-- ****************************
-- General
-- ****************************
map("i", "jk", "<Esc>:w<cr>", opts)
map("v", "dp", "_dP", opts)
map("n", "<A-t>", '<cmd>lua require("FTerm").toggle()<CR>', opts)
map("t", "<A-t>", '<C-\\><C-n><cmd>lua require("FTerm").toggle()<CR>', opts)
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
-- Telescope
-- ****************************
--map('n', '<C-p>', '<cmd>Telescope find_files<cr>', opts)
--map('n', '<C-f>', '<cmd>Telescope live_grep<cr>', opts)

-- ****************************
-- Splits
-- ****************************
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- ****************************
-- COMPLETION
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

map("n", "<leader>ni", "<cmd>lua require'npmInfo'.npmInfo()<cr>", opts)
