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

  -- Simple plugins can be specified as strings
  use '9mm/vim-closer'
  use 'junegunn/seoul256.vim'
  use 'junegunn/limelight.vim'
  use 'ryanoasis/vim-devicons'
  use 'eddyekofo94/gruvbox-flat.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'folke/lsp-colors.nvim'
  use 'hoob3rt/lualine.nvim'
  use 'shaunsingh/nord.nvim'
  use 'ap/vim-css-color'
  
  --Navigation
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  --use 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  
  --Father Pope
  use 'tpope/vim-abolish'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-dadbod'
  
  use 'kristijanhusak/vim-dadbod-ui'
  
  --Undo
  use 'mbbill/undotree'
  use 'simnalamburt/vim-mundo'
  
  --Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use 'tpope/vim-fugitive'
  use 'junegunn/gv.vim' --Git commit browser. Needs fugitive
  use 'AndrewRadev/linediff.vim' --Creates diff buffer between selected line(s)
  
  --Utilities
  use 'vimwiki/vimwiki'
  --use 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' }
  use 'scrooloose/nerdcommenter'
  use 'jiangmiao/auto-pairs'
  use 'junegunn/vim-easy-align'
  use 'SirVer/ultisnips'
  use 'folke/which-key.nvim'
  use 'folke/trouble.nvim'
  use 'svermeulen/vimpeccable'
  
  --Javascript/Node
  use 'pangloss/vim-javascript'
  use 'mxw/vim-jsx'
  use 'othree/yajs.vim'
  use 'othree/javascript-libraries-syntax.vim'
  use 'leafgarland/typescript-vim'
  
  --Other Language Stuff
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/nvim-compe'
  use 'dense-analysis/ale'
  use {
    'fatih/vim-go',
    ft = 'go'
  }
  --use 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  use 'rust-lang/rust.vim'
  use "numtostr/FTerm.nvim"
  use "mfussenegger/nvim-dap"
  use "Pocco81/DAPInstall.nvim"
end)

