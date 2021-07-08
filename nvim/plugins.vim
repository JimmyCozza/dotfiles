call plug#begin('~/.vim/plugged')

"Style
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/limelight.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/lsp-colors.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'ap/vim-css-color'

"Navigation
Plug 'scrooloose/nerdtree'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"Father Pope
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dadbod'

Plug 'kristijanhusak/vim-dadbod-ui'

"Undo
Plug 'mbbill/undotree'
Plug 'simnalamburt/vim-mundo'

"Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim' "Git commit browser. Needs fugitive
Plug 'AndrewRadev/linediff.vim' "Creates diff buffer between selected line(s)

"Utilities
Plug 'vimwiki/vimwiki'
Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' }
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'SirVer/ultisnips'
Plug 'folke/which-key.nvim'
Plug 'folke/trouble.nvim'
Plug 'svermeulen/vimpeccable'
Plug 'kristijanhusak/orgmode.nvim'

"Javascript/Node
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'leafgarland/typescript-vim'

"Other Language Stuff
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'rust-lang/rust.vim'

call plug#end()
