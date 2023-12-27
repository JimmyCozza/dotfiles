local opts = { noremap = true, silent = true } 

local function map(mode, keys, command, opt)
  local options = { silent = true }

  if opt then
    options = vim.tbl_extend("force", options, opt)
  end

  if type(keys) == "table" then
    for _, keymap in ipairs(keys) do
      M.map(mode, keymap, command, opt)
    end
    return
  end

  vim.keymap.set(mode, keys, command, opt)
end

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

