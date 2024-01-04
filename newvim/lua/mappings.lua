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

-- Leader Based Bindings
JC.leader_group_clues = {
  { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
  { mode = "n", keys = "<Leader>c", desc = "+Comment" },
  { mode = "n", keys = "<Leader>e", desc = "+Quick Edit Files" },
  { mode = "n", keys = "<Leader>f", desc = "+Find" },
  { mode = "n", keys = "<Leader>g", desc = "+Git" },
  { mode = "n", keys = "<Leader>h", desc = "+Help" },
  { mode = "n", keys = "<Leader>l", desc = "+LSP" },
  { mode = "n", keys = "<Leader>lf", desc = "LSP Format" },
  { mode = "n", keys = "<Leader>n", desc = "+NvimTree" },
  { mode = "n", keys = "<Leader>p", desc = "+Project" },
  { mode = "n", keys = "<Leader>T", desc = "+Test" },

  { mode = "x", keys = "<Leader>l", desc = "+LSP" },
}

local grep_cmd =
"lua require('telescope.builtin').live_grep({additional_args = function() return {'--glob=!package-lock.json'} end})"

-- stylua: ignore start
local leaderBindings = {
  { mode = "n", keys = "/",        cmd = grep_cmd,                                   desc = "Search Project" },
  { mode = "n", keys = "b",        cmd = "NvimTreeToggle",                           desc = "Toggle File Tree" },
  { mode = "n", keys = "cl",       cmd = "<Plug>(comment_toggle_linewise_current)",  desc = "Comment Line" },
  { mode = "n", keys = "c<space>", cmd = "<Plug>(comment_toggle_blockwise_current)", desc = "Comment Line (Block)" },
  { mode = "v", keys = "cl",       cmd = "<Plug>(comment_toggle_linewise_visual)",   desc = "Comment Line" },
  { mode = "v", keys = "c<space>", cmd = "<Plug>(comment_toggle_blockwise_visual)",  desc = "Comment Line (Block)" },
  { mode = "n", keys = "ea",       cmd = ":e $HOME/.config/awesome/rc.lua",          desc = "Edit Awesome Config" },
  { mode = "n", keys = "ep",       cmd = ":e $HOME/.config/nvim/lua/plugins.lua",    desc = "Edit Neovim Plugins" },
  { mode = "n", keys = "et",       cmd = ":e $HOME/dotfiles/wezterm/wezterm.lua",    desc = "Edit Wezterm Config" },
  { mode = "n", keys = "ev",       cmd = ":e $HOME/.config/nvim/init.lua",           desc = "Edit Neovim Config" },
  { mode = "n", keys = "ez",       cmd = ":e $HOME/dotfiles/zshrc",                  desc = "Edit Zshrc" },
  { mode = "n", keys = "gb",       cmd = "Telescope git_branches",                   desc = "Checkout Branch" },
  { mode = "n", keys = "gc",       cmd = "Telescope git_commits",                    desc = "Checkout Commit" },
  { mode = "n", keys = "gC",       cmd = "Telescope git_bcommits",                   desc = "Checkout Commit (Current file)" },
  { mode = "n", keys = "go",       cmd = "Telescope git_status",                     desc = "Git Status" },
  { mode = "n", keys = "hh",       cmd = "Telescope help_tags",                      desc = "Help Tags" },
  { mode = "n", keys = "hm",       cmd = "Telescope man_pages",                      desc = "Man Pages" },
  { mode = "n", keys = "li",       cmd = "LspInfo",                                  desc = "LSP Info" },
  { mode = "n", keys = "li",       cmd = "LspInfo",                                  desc = "LSP Info" },
  { mode = "n", keys = "nn",       cmd = "NvimTreeToggle",                           desc = "Toggle File Tree" },
  { mode = "n", keys = "nt",       cmd = "NvimTreeFindFileToggle",                   desc = "File Tree at File" },
  { mode = "n", keys = "pb",       cmd = "Telescope buffers",                        desc = "Find Buffers" },
  { mode = "n", keys = "pf",       cmd = "Telescope find_files",                     desc = "Find Files in Project" },
  { mode = "n", keys = "ps",       cmd = "Telescope grep_string",                    desc = "Search in Project" },
  { mode = "n", keys = "sc",       cmd = "nohlsearch",                               desc = "Clear Search Higlighting" },
}
-- stylua: ignore end

for _, v in pairs(leaderBindings) do
  leaderMap(v)
end
