" default (n)vim settings

let mapleader = " "

set hidden
set showcmd
set linebreak
set complete-=t " disable scanning tags
set laststatus=2
set updatetime=0
set wildignorecase
set timeoutlen=500
set ttimeoutlen=30
set winminheight=0
set matchpairs+=<:>
" set nrformats+=alpha " add aplhabet in increment/decrement
set completeopt-=preview " ignore omni complete description
set splitbelow splitright
set number relativenumber
set wildignore=*/.git/*,*.pdf,*.jpg,*jpeg,*.png,*.epub,*.mobi

set tabstop=4
set shiftwidth=4

set nobackup
set noshowmode
set noswapfile
set nostartofline

set ignorecase
set smartcase
set incsearch

if has('nvim')
	set guicursor=
	set nohlsearch
	set nosmarttab
	set noautoindent
	set inccommand=split
	set wildmode=longest:full,full
	autocmd! BufEnter term://* setlocal nonumber norelativenumber signcolumn=no

else
	set viminfo+=n~/.vim/viminfo
	set wildmode=longest,list,full

	" check if there's termwinkey variable or not
	if exists('&termwinkey') | set termwinkey=<C-p> | endif
endif

syntax on
filetype plugin indent on
