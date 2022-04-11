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
  use "lukas-reineke/indent-blankline.nvim"
  use "norcalli/nvim-colorizer.lua"

  -- Local tinkering
  --use "~/projects/npmInfo"
  --use {
  --"~/projects/youtrack",
  --requires = { "trip-zip/plenary.nvim" },
  --}
  use "trip-zip/npmInfo.nvim"

  --Navigation
  use "nvim-lua/popup.nvim"
  use "trip-zip/plenary.nvim"
  use {
    "nvim-telescope/telescope.nvim",
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
    use {
      "pwntester/octo.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("octo").setup()
      end,
    },
  }

  --Utilities
  use "nvim-treesitter/nvim-treesitter"
  use {
    "rcarriga/nvim-notify",
    disable = false,
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
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  }
  --use "preservim/nerdtree"

  use "junegunn/vim-easy-align"
  use "windwp/nvim-autopairs"
  use {
    "folke/which-key.nvim",
  }
  use {
    "folke/trouble.nvim",
    disable = false,
  }
  use {
    "folke/todo-comments.nvim",
    requires = "trip-zip/plenary.nvim",
  }
  use "hoob3rt/lualine.nvim"
  use "nvim-lua/lsp-status.nvim"

  -- Javascript/Node
  use "pangloss/vim-javascript"
  use "mxw/vim-jsx"
  use "othree/yajs.vim"
  use "othree/javascript-libraries-syntax.vim"
  use "leafgarland/typescript-vim"
  use "jose-elias-alvarez/typescript.nvim"

  -- LSP
  use "jose-elias-alvarez/null-ls.nvim"
  use "folke/lsp-colors.nvim"
  use "neovim/nvim-lspconfig"

  -- Completion
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "quangnguyen30192/cmp-nvim-ultisnips"
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
  }
  use {
    "hrsh7th/nvim-cmp",
    disable = false,
  }
  use "SirVer/ultisnips"
  use "rafamadriz/friendly-snippets"
  use {
    "fatih/vim-go",
    ft = "go",
  }
  use {
    "numtostr/FTerm.nvim",
  }
  -- DAP
  use "mfussenegger/nvim-dap"
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use "nvim-telescope/telescope-dap.nvim"
  use {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      vim.schedule(function()
        require("copilot").setup()
      end)
    end,
  }
end)
