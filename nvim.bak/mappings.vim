"=============General=============="
inoremap jk <Esc>:w<CR>
vnoremap dp "_dP
tnoremap <Esc> <C-\><C-n>

"=============Search=============="
nn remap n nzz
nnoremap N Nzz
nmap <C-n> :NERDTreeToggle<cr>

"==============Telescope================="
nnoremap <C-P> <cmd>Telescope find_files<cr>
nnoremap <C-F> <cmd>Telescope live_grep<cr>

"================SPLITS===================="
nmap <C-H> <C-W><C-H>
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>

"=============Ultisnips=================="
nmap <Leader>ns :UltiSnipsEdit<cr>

" helpers for adding semicolon or comma and removing always at end of the current line
nnoremap ;; m`A;<Esc>``
nnoremap ,, m`A,<Esc>``
nnoremap :: m`$x<Esc>``

"=============ALE=================="
map <Right> :ALENext<cr>
map <Left> :ALEPrevious<cr>
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

