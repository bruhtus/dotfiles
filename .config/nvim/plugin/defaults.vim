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
set wildignore=*/.git/*,*.pdf,*.jpg,*jpeg,*.png,*.epub,*.mobi

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
	set nohlsearch
	set nosmarttab
	set noautoindent
	set wildmode=longest:full,full

else
	set viminfo+=n~/.vim/viminfo
	set wildmode=longest,list,full

	" check if there's termwinkey variable or not
	if exists('&termwinkey')
		set termwinkey=<C-p>
	endif
endif

syntax on
filetype plugin on
