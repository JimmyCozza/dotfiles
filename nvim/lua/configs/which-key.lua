require("which-key").setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specifiy a list manually}
}

local mappings = {
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Search project" },
  ["b"] = { "<cmd>NERDTreeToggle<cr>", "Toggle Explorer" },
  ["%"] = { "<cmd>luafile %<cr>", "Run luafile" },
  d = {
    name = "+Debug",
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua _G.__fterm_lazydocker()<CR>", "Lazydocker" },
    D = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    q = { "<cmd>lua require'dap'.stop()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    u = { "<cmd>! docker-compose up -d<cr>", "docker-compose up" },
  },
  e = {
    name = "+Quick edit files",
    a = { "<cmd>:e $HOME/dotfiles/alacritty/alacritty.yml<cr>", "Edit Alacritty.yml" },
    A = { "<cmd>:e $HOME/dotfiles/awesome/rc.lua<cr>", "Edit Awesome rc.lua" },
    p = { "<cmd>:e $HOME/dotfiles/nvim/lua/plugins.lua<cr>", "Edit Plugfile" },
    v = { "<cmd>:e $HOME/.config/nvim/init.lua<cr>", "Edit Vimrc" },
    w = { "<cmd>:e $HOME/dotfiles/nvim/lua/configs/which-key.lua<cr>", "Edit Which Key" },
    z = { "<cmd>:e $HOME/dotfiles/zshrc<cr>", "Edit Zshrc" },
  },
  g = {
    name = "+Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    B = { "<cmd>Git blame<cr>", "Git blame" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
    d = { "<cmd>Git diff<cr>", "Git diff" },
    g = { "<CMD>lua _G.__fterm_lazygit()<CR>", "Lazygit" },
    j = { "<cmd>NextHunk<cr>", "Next Hunk" },
    k = { "<cmd>PrevHunk<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame Line" },
    o = { "<cmd>Telescope git_status<cr>", "Git Status" },
    p = { "<cmd>PreviewHunk<cr>", "Preview Hunk" },
    r = { "<cmd>ResetHunk<cr>", "Reset Hunk" },
    R = { "<cmd>ResetBuffer<cr>", "Reset Buffer" },
    s = { "<cmd>Neogit kind=split<cr>", "Neogit Status" },
    u = { "<cmd>UndoStageHunk<cr>", "Undo Stage Hunk" },
  },
  h = {
    name = "+Help",
    b = { "<cmd>lua _G.__fterm_bpytop()<cr>", "Bpytop" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  },
  l = {
    name = "+LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    i = { "<cmd>LspInfo<cr>", "LSP Info" },
    I = { "<cmd>LspInstallInfo<cr>", "LSP Installer Info" },
    q = { "<cmd>lua vim.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>LspStart<cr>", "LSP Start" },
    S = { "<cmd>LspStop<cr>", "LSP Stop" },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
  },
  n = {
    name = "+NERDTree",
    n = { "<cmd>NERDTreeToggle<cr>", "Toggle Explorer" },
    t = { "<cmd>NERDTreeFind<cr>", "Find at file" },
  },
  p = {
    name = "+Project",
    f = { "<cmd>Telescope find_files<cr>", "Find file in project" },
    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    q = { "<cmd>TodoQuickFix<cr>", "Send TODOs to QuickFix List" },
    s = { "<cmd>Telescope grep_string<cr>", "Search string under cursor" },
    t = { "<cmd>TodoTelescope<cr>", "Search TODOs" },
  },
  s = {
    name = "+Search",
    c = { "<cmd>nohlsearch<cr>", "Clear Search Highlighting" },
  },
  t = {
    name = "+Trouble",
    c = { "<cmd>tabc<cr>", "Close Tab" },
    t = { "<cmd>TodoTrouble<cr>", "Send TODOs to Trouble List" },
  },
  w = {
    name = "Vim Wiki",
    b = { "<cmd>Vimwiki2HTMLBrowse<cr>", "Export and Open" },
    h = { "<cmd>VimwikiAll2HTML<cr>", "Export all" },
  },
  y = {
    name = "+Youtrack",
    c = { "<cmd>lua require('youtrack').issues.comment()<cr>", "Comment on issue" },
    C = { "<cmd>lua require('youtrack').issues.create()<cr>", "Create issue" },
    i = { "<cmd>lua require('youtrack').issues.list()<cr>", "Get my issues" },
    I = { "<cmd>lua require('youtrack').issues.get()<cr>", "Get single issue" },
    p = { "<cmd>lua require('youtrack').projects.list()<cr>", "Get projects" },
    P = { "<cmd>lua require('youtrack').projects.get()<cr>", "Get single project" },
  },
}
local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}
local wk = require "which-key"
wk.register(mappings, opts)
