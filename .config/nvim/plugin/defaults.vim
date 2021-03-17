" default (n)vim settings

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

set tabstop=4
set shiftwidth=4

set nobackup
set noshowmode
set noswapfile

set ignorecase
set smartcase
set incsearch

if has('nvim')
	set guicursor=
	set wildmode=longest:full,full
	set noautoindent
	set nohlsearch
	set nosmarttab
else
	set wildmode=longest,list,full
	set termwinkey=<C-p>
	set viminfo+=n~/.vim/viminfo
endif

syntax on
filetype plugin on
