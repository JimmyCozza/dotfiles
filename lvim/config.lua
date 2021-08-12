require('mapping')

-- ****************************
-- General Settings
-- ****************************
lvim.format_on_save = true
lvim.lint_on_save = true
vim.cmd [[ set showtabline=0 ]] --if I so much as sniff a tabline, I riot.

-- Colorscheme
vim.g.seoul256_italic_comments = true
vim.g.seoul256_contrast = true
vim.g.seoul256_borders = true
vim.g.seoul256_disable_background = true
lvim.colorscheme = "seoul256"
lvim.transparent_window = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["/"] = {"<cmd>Telescope live_grep<cr>", "Search project"}
lvim.builtin.which_key.vmappings["c"] = {
  name = "+code",
  space = { ":CommentToggle<CR>", "Comment"}
}
lvim.builtin.which_key.mappings["c"] = {
  name = "+code",
  l = { "<cmd>CommentToggle<CR>", "Comment"}
}
lvim.builtin.which_key.mappings["d"] = {
  name = "+Debug",
  b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
  c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
  d = {"<CMD>lua _G.__fterm_lazydocker()<CR>", "Lazydocker"},
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
  u = {"<cmd>! docker-compose up -d<cr>", "docker-compose up"}
}
lvim.builtin.which_key.mappings["e"] = {
  name = "+Quick edit files",
  a = {"<cmd>:e $HOME/dotfiles/alacritty.yml<cr>", "Edit Alacritty.yml"},
  f = {"<cmd>ALEFix<cr>", "ALE Fix"},
  v = {"<cmd>:e $HOME/.config/lvim/config.lua<cr>", "Edit Vimrc"},
  z = {"<cmd>:e $HOME/dotfiles/zshrc<cr>", "Edit Zshrc"}
}
lvim.builtin.which_key.mappings["h"] = {
  name = "+Help",
  b = {"<cmd>lua _G.__fterm_bpytop()<cr>", "Bpytop"},
  h = {"<cmd>Telescope help_tags<cr>", "Help Tags"},
  m = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
}
lvim.builtin.which_key.mappings["n"] = {
  name = "+NvimTree",
  n = {"<cmd>NvimTreeToggle<cr>", "Toggle Explorer"},
  t = {"<cmd>NvimTreeFind<cr>", "Find at file"}
}
lvim.builtin.which_key.mappings["p"] = {
  name = "+Project",
  f = {"<cmd>Telescope find_files<cr>", "Find file in project"},
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  q = {"<cmd>TodoQuickFix<cr>", "Send TODOs to QuickFix List"},
  s = {"<cmd>Telescope grep_string<cr>", "Search string under cursor"},
  t = {"<cmd>TodoTelescope<cr>", "Search TODOs"}
}
lvim.builtin.which_key.mappings["s"] = {
    name = "+Search",
    c = {"<cmd>nohlsearch<cr>", "Clear Search Highlighting"}
  }
lvim.builtin.which_key.mappings["w"] = {
  name = "Vim Wiki",
  b = {"<cmd>Vimwiki2HTMLBrowse<cr>", "Export and Open"},
  h = {"<cmd>VimwikiAll2HTML<cr>", "Export all"}
}
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
}

-- ****************************
-- Plugin Configurations
-- ****************************
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.bufferline.active = false
lvim.builtin.dashboard.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }

-- Additional Plugins
lvim.plugins = {
  {'junegunn/seoul256.vim'},
  {'numtostr/FTerm.nvim'},
  {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
    require("todo-comments").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
    end
  },
  {"ray-x/lsp_signature.nvim",
    config = function() require"lsp_signature".on_attach() end,
    event = "InsertEnter"
  }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
