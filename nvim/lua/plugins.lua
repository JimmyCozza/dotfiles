local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  execute "packadd packer.nvim"
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require("packer").startup(function()
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Visualization
  use "ryanoasis/vim-devicons"
  use "kyazdani42/nvim-web-devicons"
  use "shaunsingh/nord.nvim"
  use "shaunsingh/seoul256.nvim"
  use "eddyekofo94/gruvbox-flat.nvim"
  use "ap/vim-css-color"
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require "configs.colorizer"
    end,
  }

  -- Local tinkering
  use {
    "~/projects/youtrack",
    requires = { "trip-zip/plenary.nvim" },
  }
  --use {
  --'trip-zip/youtrack',
  --requires = {'trip-zip/plenary.nvim'}
  --}

  --Navigation
  use "nvim-lua/popup.nvim"
  use "trip-zip/plenary.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "configs.telescope"
    end,
  }

  -- tpope
  use "tpope/vim-abolish"
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-fugitive"
  use "tpope/vim-endwise"

  -- Undo
  use "mbbill/undotree"
  use "simnalamburt/vim-mundo"

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "trip-zip/plenary.nvim",
    },
    config = function()
      require "configs.gitsigns"
    end,
  }
  use {
    "TimUntersberger/neogit",
    requires = "trip-zip/plenary.nvim",
    config = function()
      require "configs.neogit"
    end,
  }

  --Utilities
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "configs.treesitter"
    end,
  }
  use "rstacruz/vim-closer"
  use {
    "rcarriga/nvim-notify",
    disable = false,
    config = function()
      require "configs.notify"
    end,
  }
  use {
    "vimwiki/vimwiki",
    config = function()
      vim.g.vimwiki_list = {
        {
          path = "~/notes/vimwiki",
        },
      }
    end,
  }
  use "scrooloose/nerdcommenter"
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require "configs.nvim-tree"
    end,
  }
  use "junegunn/vim-easy-align"
  use {
    "windwp/nvim-autopairs",
    config = function()
      require "configs.autopairs"
    end,
  }
  use "SirVer/ultisnips"
  --use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
  use {
    "folke/which-key.nvim",
    config = function()
      require "configs.which-key"
    end,
  }
  use {
    "folke/trouble.nvim",
    disable = false,
  }
  use {
    "folke/todo-comments.nvim",
    requires = "trip-zip/plenary.nvim",
    config = function()
      require "configs.todo-comments"
    end,
  }
  use {
    "kristijanhusak/orgmode.nvim",
    disable = false,
    config = function()
      require "configs.orgmode"
    end,
  }
  use {
    "akinsho/org-bullets.nvim",
    disable = false,
    config = function()
      require("org-bullets").setup {
        symbols = { "◉", "○", "✸", "✿" },
      }
    end,
  }
  use {
    "hoob3rt/lualine.nvim",
    config = function()
      require "configs.lualine"
    end,
  }

  -- Javascript/Node
  use "pangloss/vim-javascript"
  use "mxw/vim-jsx"
  use "othree/yajs.vim"
  use "othree/javascript-libraries-syntax.vim"
  use "leafgarland/typescript-vim"

  -- LSP
  use "jose-elias-alvarez/null-ls.nvim"
  use "folke/lsp-colors.nvim"
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").tsserver.setup {}
      require("lspconfig").gopls.setup {}
    end,
  }
  use "williamboman/nvim-lsp-installer"
  --use 'glepnir/lspsaga.nvim'

  -- Completion
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  --use "saadparwaiz1/cmp_luasnip"
  use "quangnguyen30192/cmp-nvim-ultisnips"
  use {
    "hrsh7th/nvim-cmp",
    disable = false,
    config = function()
      require "configs.cmp"
    end,
  }
  --use {
  --'fatih/vim-go',
  --ft = 'go'
  --}
  use {
    "numtostr/FTerm.nvim",
    config = function()
      require "configs.floatterm"
    end,
  }
  -- DAP
  --use {
  --'mfussenegger/nvim-dap',
  --config = function()
  --require('configs.dap')
  --end
  --}
  --use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  --use 'theHamsta/nvim-dap-virtual-text'
  --use 'nvim-telescope/telescope-dap.nvim'
  use "github/copilot.vim"
end)
