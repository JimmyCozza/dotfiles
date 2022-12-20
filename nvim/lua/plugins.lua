local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return require("packer").startup(function()
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Visualization
  use("ryanoasis/vim-devicons")
  use("kyazdani42/nvim-web-devicons")
  use("ap/vim-css-color")
  use("norcalli/nvim-colorizer.lua")

  -- color
  use("ellisonleao/gruvbox.nvim")
  use("shaunsingh/nord.nvim")
  use("shaunsingh/seoul256.nvim")
  use({
    "catppuccin/nvim",
    as = "catppuccin",
  })
  use("trip-zip/npmInfo.nvim")

  --Navigation
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")

  -- tpope
  use("tpope/vim-abolish")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-fugitive")
  use("tpope/vim-endwise")

  -- Undo
  use("mbbill/undotree")
  use("simnalamburt/vim-mundo")

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  --Utilities
  use("nvim-orgmode/orgmode")
  use({
    "nvim-neorg/neorg",
    config = function()
      require("neorg").setup({})
    end,
    requires = "nvim-lua/plenary.nvim",
  })
  use("nvim-treesitter/nvim-treesitter")
  use({
    "nvim-treesitter/playground",
    config = function()
      require("nvim-treesitter.configs").setup({
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      })
    end,
  })
  use("rcarriga/nvim-notify")
  use("nvim-neotest/neotest-plenary")
  use("haydenmeade/neotest-jest")
  use("nvim-neotest/neotest-go")
  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-plenary"),
          require("neotest-go"),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  })
  use({
    "vimwiki/vimwiki",
    config = function()
      vim.g.vimwiki_list = {
        {
          path = "~/notes/vimwiki",
        },
      }
    end,
  })
  --use("scrooloose/nerdcommenter")
  use("numToStr/Comment.nvim")
  use("preservim/nerdtree")

  use("junegunn/vim-easy-align")
  use("windwp/nvim-autopairs")
  use("folke/which-key.nvim")
  use("folke/trouble.nvim")
  use({
    "folke/todo-comments.nvim",
    requires = "trip-zip/plenary.nvim",
  })
  use("hoob3rt/lualine.nvim")
  use("feline-nvim/feline.nvim")
  -- Formatting
  use("gpanders/editorconfig.nvim")

  -- LSP
  use("folke/lsp-colors.nvim")
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("nvim-lua/lsp-status.nvim")

  -- Completion
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("quangnguyen30192/cmp-nvim-ultisnips")
  use({
    "hrsh7th/nvim-cmp",
    disable = false,
  })
  use("SirVer/ultisnips")
  use("rafamadriz/friendly-snippets")
  use({
    "fatih/vim-go",
    ft = "go",
  })
  use("numtostr/FTerm.nvim")
  --use "github/copilot.vim"
  use({
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  })
  use({
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  })

  -- DAP
  use("mfussenegger/nvim-dap")
  use({
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,
  })
  use({
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
    end,
  })
  use({
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  })
  use("nvim-telescope/telescope-dap.nvim")
end)
