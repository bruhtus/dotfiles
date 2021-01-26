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
call plug#end()

set path+=**
set laststatus=2
set showcmd
set ttimeoutlen=30
set number relativenumber

set nowrap
set nobackup
set noshowmode
set noswapfile

set ignorecase
set smartcase
set hlsearch
set incsearch
set statusline=%{anzu#search_status()}
"set shortmess-=S "default vim search result count

let mapleader =" "

" set goyo by typing space + g
map <leader>g :Goyo \| set linebreak<CR>

" limelight integration with goyo
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

" vim-pencil integration with goyo
autocmd User GoyoEnter SoftPencil " Turn on
autocmd User GoyoLeave TogglePencil " Turn off

" open fzf to search all files in home directory
map <leader>e :Files ~<CR>

" set vim to copy to clipboard and paste from clipboard
vnoremap <C-y> "+y
map <C-p> "+p

" set enter as :
map <CR> :

colorscheme seoul256
let g:seoul256_background = 233
colo seoul256

" better whitespace config
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" lightline config
let g:lightline = {
      \ 'colorscheme': 'seoul256',
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
let g:pymode_breakpoint_bind = '<leader>br'
