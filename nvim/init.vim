so $HOME/dotfiles/plugins.vim "Plug File
so $HOME/.config/nvim/mappings.vim "All mappings beginning with <Leader> are defined in which-key.lua
luafile $HOME/.config/nvim/plugins/which-key.lua
luafile $HOME/.config/nvim/plugins/telescope.lua
luafile $HOME/.config/nvim/plugins/lualine.lua
luafile $HOME/.config/nvim/plugins/compe.lua
luafile $HOME/.config/nvim/plugins/orgmode.lua
luafile $HOME/.config/nvim/lsp/init.lua

"=============General Settings=============="
let mapleader = ' '
set number
set nowrap
set tabstop=2
set softtabstop=2
set shiftwidth=2
set hidden
set expandtab
set ignorecase
set smartcase
set noerrorbells
set clipboard=unnamedplus
set cursorline
set inccommand=nosplit
set nopaste
set mouse=a
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/tmp/undo/
set completeopt-=preview
set splitbelow
set splitright

"=============Visual====================="

let g:nord_disable_background = 1
colo nord

highlight Normal ctermbg=none
highlight NonText ctermbg=none

"let g:vim_markdown_preview_github = 1
let g:vim_markdown_preview_browser = 'Google Chrome'
let vim_markdown_preview_hotkey='<C-m>'

"=============Vim-Go====================="
let g:go_def_mode = 'godef'
let g:go_fmt_command = "goimports"

"=============Auto-Commands=============="
"Automatically source the Vimrc file on save.
augroup autosourcing
autocmd!
autocmd BufWritePost $HOME/dotfiles/nvim/init.vim source %
augroup END

"=============LSP=================="
"lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set completeopt=menuone,noinsert,noselect

"=============Ultisnips=================="
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/dotfiles/UltiSnips']

"================Wiki================="
let g:vimwiki_list = [{'path': '~/vimwiki/'}]
                     "\ 'syntax': 'markdown', 'ext': '.md'}]

"================LINTING===================="
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'css': ['eslint'],
\   'json': ['prettier'],
\}
let g:ale_fix_on_save = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = '--'

"===================================="
