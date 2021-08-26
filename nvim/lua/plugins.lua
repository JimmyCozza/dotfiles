-- ****************************
-- Bootstrapping Packer
-- ****************************
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end


-- ****************************
-- Plugins
-- ****************************
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Visualization
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  use 'folke/lsp-colors.nvim'
  use 'shaunsingh/nord.nvim'
  use 'shaunsingh/seoul256.nvim'
  use 'eddyekofo94/gruvbox-flat.nvim'
  use 'ap/vim-css-color'
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end
}
  
  --Navigation
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
  'nvim-telescope/telescope.nvim',
  config = function()
    require('configs.telescope')
  end
  }
  
  --Father Pope
  use 'tpope/vim-abolish'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-endwise'
  
  --Undo
  use 'mbbill/undotree'
  use 'simnalamburt/vim-mundo'
  
  --Git
  use {
  'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require('gitsigns').setup() end
  }
  
  --Utilities
  use 'rstacruz/vim-closer'
  use "rcarriga/nvim-notify"
  use {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '~/notes/vimwiki'
        }
      }
    end
  }
  use 'scrooloose/nerdcommenter'
  use 'scrooloose/nerdtree'
  use 'junegunn/vim-easy-align'
  use 'SirVer/ultisnips'
  use {
    'folke/which-key.nvim',
    config = function()
      require('configs.which-key')
    end
  }
  use 'folke/trouble.nvim'
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('configs.todo-comments') end
  }
  use 'svermeulen/vimpeccable'
  use {
    'kristijanhusak/orgmode.nvim',
    config = function()
      require('orgmode').setup{}
    end
  }
  use {
    "akinsho/org-bullets.nvim",
    config = function()
      require("org-bullets").setup {
        symbols = { "◉", "○", "✸", "✿" }
      }
    end
  }


  use 'hoob3rt/lualine.nvim'

  
  --Javascript/Node
  use 'pangloss/vim-javascript'
  use 'mxw/vim-jsx'
  use 'othree/yajs.vim'
  use 'othree/javascript-libraries-syntax.vim'
  use 'leafgarland/typescript-vim'
  
  --Other Language Stuff
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use {
    'hrsh7th/nvim-compe',
    config = function() 
      require('configs.compe')
    end
  }
  use 'dense-analysis/ale'
  use {
    'fatih/vim-go',
    ft = 'go'
  }
  use 'rust-lang/rust.vim'
  use {
    'numtostr/FTerm.nvim',
    config = function()
      require('configs.floatterm')
    end
  }
  use {
    'mfussenegger/nvim-dap',
    config = function() 
      require('configs.dap')
    end
  }
  use 'Pocco81/DAPInstall.nvim'
end)

