call plug#begin()
Plug 'junegunn/seoul256.vim'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-pencil'
Plug 'francoiscabrol/ranger.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'dominikduda/vim_current_word'
Plug 'kshenoy/vim-signature'
Plug 'ntpeters/vim-better-whitespace'
Plug 'xtal8/traces.vim'
Plug 'osyo-manga/vim-anzu'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
Plug 'vimwiki/vimwiki'
call plug#end()

set showcmd
set linebreak
set laststatus=2
set ttimeoutlen=30
set splitbelow splitright
set number relativenumber

set nobackup
set noshowmode
set noswapfile
set nocompatible

set ignorecase
set smartcase
set incsearch
set statusline=%{anzu#search_status()}
"set shortmess-=S "default vim search result count

filetype plugin on
syntax on

let mapleader =" "
let $FZF_DEFAULT_COMMAND = "find ~ -type f | egrep -v '*\.jpg|*\.jpeg|*\.png|*\.epub|*\.mobi|*\.pdf|*\.mp4|*\.svg|miniconda3/|gems/|\.local/'"
let g:vimwiki_list = [{'path': '~/Sync/wiki', 'syntax': 'markdown', 'ext': '.md'}]

" matching parenthesis rainbow config
let g:rainbow_active = 0
nnoremap <leader>s :RainbowToggle<CR>

" set goyo by typing space + g
map <leader>g :Goyo<CR>

" limelight and vim-pencil integration with goyo
autocmd User GoyoEnter Limelight | SoftPencil
autocmd User GoyoLeave Limelight! | NoPencil

" ranger config
let g:ranger_map_keys = 0
map <leader>e :Ranger<CR>

" open fzf to search all files in home directory
map <leader>f :Files ~<CR>

" space r to compile groff and space p to display the result
map <leader>r :w! \| !pdfroff -mspdf -t % > %:r.pdf<CR><CR>
map <leader>p :!zathura %:r.pdf&<CR><CR>

" jump to any mark with space j
nnoremap <leader>j `

" set black hole register to c, C, s, S, x, X, D, and space d
nnoremap c "_c
nnoremap C "_C
nnoremap s "_s
nnoremap S "_S
nnoremap x "_x
nnoremap X "_X
nnoremap D "_D
nnoremap <leader>d "_d

" set vim to copy to clipboard and paste from clipboard
vnoremap <C-y> "+y
map <C-p> "+p

" set enter as :
map <CR> :

" set ZX as :w
nnoremap ZX :w<CR>

" set ZA as :on
nnoremap ZA :on<CR>

" set ZC as :filetype detect
nnoremap ZC :filetype detect<CR>

" set ZS as :reg
nnoremap ZS :reg<CR>

" set ZD as :marks
nnoremap ZD :marks<CR>

" colorscheme config
let g:seoul256_background = 233
colo seoul256

" better-whitespace config
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" lightline config
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ],
      \              [ 'percent', 'fileencoding' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l/%L',
      \ },
      \ }

" anzu config
let g:anzu_enable_CursorMoved_AnzuUpdateSearchStatus=1

" python-mode config
let g:pymode_lint_checkers = ['pyflakes']
let g:pymode_trim_whitespaces = 0
let g:pymode_options = 0
let g:pymode_rope = 0
let g:pymode_indent = 1
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 1
let g:pymode_run_bind = '<leader>br'
