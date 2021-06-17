so $HOME/dotfiles/nvim/plugins.vim "Plug File
so $HOME/.config/nvim/mappings.vim "All mappings beginning with <Leader> are defined in which-key.lua
luafile $HOME/.config/nvim/plugins/which-key.lua
luafile $HOME/.config/nvim/plugins/telescope.lua
luafile $HOME/.config/nvim/plugins/lualine.lua
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
au! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $NVIMRC"

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

"-================DAP-===================="
lua << EOF
local dap = require('dap')

local function debugJest(testName, filename)
  print("starting " .. testName .. " in " .. filename)
  dap.run({
      type = 'node2',
      request = 'launch',
      cwd = vim.fn.getcwd(),
      runtimeArgs = {'--inspect-brk', '/usr/local/bin/jest', '--no-coverage', '-t', testName, '--', filename},
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
      console = 'integratedTerminal',
      port = 9229,
      })
end

local function attach()
  print("attaching")
  dap.run({
      type = 'node2',
      request = 'attach',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
      })
end

local function attachToRemote()
  print("attaching")
  dap.run({
      type = 'node2',
      request = 'attach',
      address = "127.0.0.1",
      port = 9229,
      localRoot = vim.fn.getcwd(),
      remoteRoot = "/home/vcap/app",
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
      })
end

local debugHelper = {
  debugJest = debugJest,
  attach = attach,
  attachToRemote = attachToRemote,
}
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/apps/vscode-node-debug2/out/src/nodeDebug.js'},
}
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
EOF
nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <S-k> :lua require'dap'.step_out()<CR>
nnoremap <S-l> :lua require'dap'.step_into()<CR>
nnoremap <S-j> :lua require'dap'.step_over()<CR>
nnoremap <leader>ds :lua require'dap'.stop()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>dk :lua require'dap'.up()<CR>
nnoremap <leader>dj :lua require'dap'.down()<CR>
nnoremap <leader>d_ :lua require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
nnoremap <leader>di :lua require'dap.ui.variables'.hover()<CR>
vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>d? :lua require'dap.ui.variables'.scopes()<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
nnoremap <leader>da debugHelper.attach()<CR>
nnoremap <leader>dA debugHelper.attachToRemote()<CR>

" new!
nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<CR>
nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
" Plug 'nvim-telescope/telescope-dap.nvim'
lua << EOF
require('telescope').setup()
require('telescope').load_extension('dap')
EOF
nnoremap <leader>df :Telescope dap frames<CR>
nnoremap <leader>dc :Telescope dap commands<CR>
nnoremap <leader>db :Telescope dap list_breakpoints<CR>
