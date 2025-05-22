local h = require("helpers")

local opts = { noremap = true, silent = true }

-- ****************************
-- General Mappings (non-leader)
-- ****************************
h.map("i", "jk", "<Esc>:w<cr>", opts)
h.map("v", "dp", "_dP", opts)
h.map("t", "<esc>", "<C-\\><C-n>", { silent = true })
h.map("n", "<Right>", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
h.map("n", "<Left>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)

-- ****************************
-- Search
-- ****************************
h.map("n", "n", "nzz", opts)
h.map("n", "N", "Nzz", opts)

-- ****************************
-- Splits
-- ****************************
h.map("n", "<C-h>", "<C-w>h", opts)
h.map("n", "<C-j>", "<C-w>j", opts)
h.map("n", "<C-k>", "<C-w>k", opts)
h.map("n", "<C-l>", "<C-w>l", opts)

-- ****************************
-- Completion
-- ****************************
h.map("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
h.map("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
h.map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
h.map("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

-- ****************************
-- Other Stuff
-- ****************************
-- helpers for adding semicolon or comma and removing always at end of the current line
h.map("n", ";;", "m`A;<Esc>`", opts)
h.map("n", ",,", "m`A,<Esc>`", opts)
h.map("n", "::", "m`$x<Esc>`", opts)

-- Move lines up or down
h.map("i", "<A-j>", "<Esc>:move .+1<cr>==gi", opts)
h.map("i", "<A-k>", "<Esc>:move .-2<cr>==gi", opts)
h.map("v", "<A-j>", "<Esc>:move .+1<cr>gv-gv", opts)
h.map("v", "<A-k>", "<Esc>:move .-2<cr>gv-gv", opts)

--Quickfix List stuff
h.map("n", "<UP>", "<cmd>cprevious<cr>", opts)
h.map("n", "<DOWN>", "<cmd>cnext<cr>", opts)

-- ****************************
-- Define which-key groups
-- ****************************
h.group("a", "+AI")
h.group("b", "+Buffer")
h.group("c", "+Comment")
h.group("d", "+Database")
h.group("e", "+Edit Files")
h.group("f", "+Find")
h.group("g", "+Git")
h.group("h", "+Help")
h.group("l", "+LSP")
h.group("n", "+NvimTree")
h.group("p", "+Project")
h.group("T", "+Test")

h.group("<Leader>l", "+LSP")

-- ****************************
-- Leader mappings by category
-- ****************************

-- Search mappings
local grep_cmd =
  "lua require('telescope.builtin').live_grep({additional_args = function() return {'--glob=!package-lock.json'} end})"
h.lmap("n", "/", grep_cmd, "Search Project")

-- File tree mappings
h.lmap("n", "b", "NvimTreeToggle", "Toggle File Tree")
h.lmap("n", "nn", "NvimTreeToggle", "Toggle File Tree")
h.lmap("n", "nt", "NvimTreeFindFileToggle", "File Tree at File")

-- Comment mappings
h.lmap("n", "cl", "<Plug>(comment_toggle_linewise_current)", "Comment Line")
h.lmap("n", "c<space>", "<Plug>(comment_toggle_blockwise_current)", "Comment Line (Block)")
h.lmap("v", "cl", "<Plug>(comment_toggle_linewise_visual)", "Comment Line")
h.lmap("v", "c<space>", "<Plug>(comment_toggle_blockwise_visual)", "Comment Line (Block)")

-- Database mappings
h.lmap("n", "dt", ":DBUIToggle", "Toggle DB UI")

-- Config file editing shortcuts
h.map_group({
  { "ea", ":e $HOME/.config/awesome/rc.lua", "Edit Awesome Config" },
  { "ep", ":e $HOME/.config/nvim/lua/plugins.lua", "Edit Neovim Plugins" },
  { "et", ":e $HOME/dotfiles/wezterm/wezterm.lua", "Edit Wezterm Config" },
  { "ev", ":e $HOME/.config/nvim/init.lua", "Edit Neovim Config" },
  { "ez", ":e $HOME/dotfiles/zshrc", "Edit Zshrc" },
})

-- Git mappings
h.map_group({
  { "gb", "Telescope git_branches", "Checkout Branch" },
  { "gB", "Git blame", "Git Blame" },
  { "gc", "Telescope git_commits", "Checkout Commit" },
  { "gC", "Telescope git_bcommits", "Checkout Commit (Current file)" },
  { "go", "Telescope git_status", "Git Status" },
})

-- Help mappings
h.map_group({
  { "hh", "Telescope help_tags", "Help Tags" },
  { "hm", "Telescope man_pages", "Man Pages" },
})

-- LSP mappings
h.map_group({
  { "li", "LspInfo", "LSP Info" },
  { "lf", "LspFormat", "Format Document" },
})

-- Project mappings
h.map_group({
  { "pb", "Telescope buffers", "Find Buffers" },
  { "pf", "Telescope find_files", "Find Files in Project" },
  { "ps", "Telescope grep_string", "Search in Project" },
  { "pps", "Lazy sync", "Lazy Sync" },
})

-- Search clear
h.lmap("n", "sc", "nohlsearch", "Clear Search Highlighting")

-- CodeCompanion mappings
h.map_group({
  { "ac", ":CodeCompanionChat Toggle", "Toggle Chat" },
  { "aa", ":CodeCompanionActions", "Actions Menu" },
  { mode = "v", keys = "as", cmd = ":CodeCompanionChat Add", desc = "Send Selection to Chat" },
  { mode = "v", keys = "ai", cmd = ":'<,'>CodeCompanion", desc = "Inline Edit Selection" },
})

-- Initialize which-key integration
h.init_which_key()
