local map = vim.api.nvim_set_keymap
-- ****************************
-- General
-- ****************************
map('i', 'jk', '<Esc>:w<cr>', { noremap = true })
map('v', 'dp', '_dP', { noremap = true })
map('n', '<A-t>', '<cmd>lua require("FTerm").toggle()<CR>', { noremap = true })
map('t', '<A-t>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<CR>', { noremap = true })

-- ****************************
-- Search
-- ****************************
map('n', 'n', 'nzz', { noremap = true })
map('n', 'N', 'Nzz', { noremap = true })
map('n', '<C-n>', ':NvimTreeToggle<cr>', {})

-- ****************************
-- Telescope
-- ****************************
--map('n', '<C-p>', '<cmd>Telescope find_files<cr>', { noremap = true })
--map('n', '<C-f>', '<cmd>Telescope live_grep<cr>', { noremap = true })

-- ****************************
-- Splits
-- ****************************
map('n', '<C-h>', '<C-w>h', { silent = true })
map('n', '<C-j>', '<C-w>j', { silent = true })
map('n', '<C-k>', '<C-w>k', { silent = true })
map('n', '<C-l>', '<C-w>l', { silent = true })


-- ****************************
-- ALE
-- ****************************
map('n', '<Right>', '<cmd>ALENext<cr>', {})
map('n', '<Left>', '<cmd>ALEPrevious<cr>', {})

-- ****************************
-- COMPLETION
-- ****************************
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- ****************************
-- Other Stuff
-- ****************************
-- helpers for adding semicolon or comma and removing always at end of the current line
map('n', ';;', 'm`A;<Esc>`', { noremap = true })
map('n', ',,', 'm`A,<Esc>`', { noremap = true })
map('n', '::', 'm`$x<Esc>`', { noremap = true })

-- Move lines up or down
map('i', '<A-j>', '<Esc>:move .+1<cr>==gi', {})
map('i', '<A-k>', '<Esc>:move .-2<cr>==gi', {})
map('v', '<A-j>', '<Esc>:move .+1<cr>gv-gv', {})
map('v', '<A-k>', '<Esc>:move .-2<cr>gv-gv', {})

--Quickfix List stuff
map('n', '<UP>', '<cmd>cprevious<cr>', {})
map('n', '<DOWN>', '<cmd>cnext<cr>', {})
