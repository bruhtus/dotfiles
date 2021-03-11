" default vim settings

let mapleader = " "

set hidden
set showcmd
set linebreak
set laststatus=2
set updatetime=0
set wildignorecase
set ttimeoutlen=30
set winminheight=0
set signcolumn=yes
set matchpairs+=<:>
set splitbelow splitright
set number relativenumber
set viminfo+=n~/.vim/viminfo
set wildmode=longest,list,full

set tabstop=4
set shiftwidth=4

set nobackup
set noshowmode
set noswapfile

set ignorecase
set smartcase
set incsearch
" set shortmess-=S "default vim search result count

syntax on
filetype plugin on
