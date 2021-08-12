
--[[
local mappings = {
    g = {
      name = "+Git",
      b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
      B = {"<cmd>Git blame<cr>", "Git blame"},
      c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
      C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"},
      d = {"<cmd>Git diff<cr>", "Git diff"},
      g = {"<CMD>lua _G.__fterm_lazygit()<CR>", "Lazygit"},
      j = {"<cmd>NextHunk<cr>", "Next Hunk"},
      k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame Line" },
      o = {"<cmd>Telescope git_status<cr>", "Git Status"},
      p = {"<cmd>PreviewHunk<cr>", "Preview Hunk"},
      r = {"<cmd>ResetHunk<cr>", "Reset Hunk"},
      R = {"<cmd>ResetBuffer<cr>", "Reset Buffer"},
      s = {"<cmd>Neogit kind=split<cr>", "Neogit Status"},
      u = {"<cmd>UndoStageHunk<cr>", "Undo Stage Hunk"},
    },
    s = {
      name = "+Search",
      c = {"<cmd>nohlsearch<cr>", "Clear Search Highlighting"}
    },
    t = {
      name = "+Tabs",
      c = {"<cmd>tabc<cr>", "Close Tab"}
    },
    w = {
      name = "Vim Wiki",
      b = {"<cmd>Vimwiki2HTMLBrowse<cr>", "Export and Open"},
      h = {"<cmd>VimwikiAll2HTML<cr>", "Export all"}
    },
    y = {
      name = "+Yarn",
      i = {"<cmd>! yarn install<cr>", "Yarn Install"},
      t = {"<cmd>! yarn test<cr>", "Yarn Test"}
    }
}
local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}
]]
