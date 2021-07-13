--==============General================
vim.api.nvim_set_keymap("i", "jk", "<Esc>:w<cr>", { noremap = true })
vim.api.nvim_set_keymap("v", "dp", "_dP", { noremap = true })

--==============Search=================
vim.api.nvim_set_keymap("n", "n", "nzz", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<cr>", {})

--=============Telescope===============
vim.api.nvim_set_keymap("n", "<C-p>", "", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-f>", "", { noremap = true })

--==============Splits=================
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- helpers for adding semicolon or comma and removing always at end of the current line
vim.api.nvim_set_keymap("n", ";;", "m`A;<Esc>`", { noremap = true })
vim.api.nvim_set_keymap("n", ",,", "m`A,<Esc>`", { noremap = true })
vim.api.nvim_set_keymap("n", "::", "m`$x<Esc>`", { noremap = true })

