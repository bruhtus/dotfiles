" default (n)vim settings

let mapleader = ' '

set title
set hidden
set showcmd
set linebreak
set lazyredraw
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

set autoindent
set tabstop=4
set softtabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab

set nobackup
set noshowmode
set noswapfile
set nostartofline

set ignorecase
set smartcase
set incsearch

" in case I don't want to use statusline
if &ruler | set rulerformat=%-13.(%r%m%)\ %P | endif

if has('nvim')
  set guicursor=
  set nohlsearch
  set nosmarttab
  set noautoindent
  set inccommand=split
  set wildmode=longest:full,full

  augroup TermBuffer
    autocmd!
    autocmd TermOpen term://*
          \ setlocal nonumber norelativenumber signcolumn=no |
          \ startinsert
  augroup END

else
  set viminfo+=n~/.vim/viminfo
  set wildmode=longest,list,full
  set backspace=indent,eol,start
  set complete-=i " disable scanning current and included files
  set nrformats-=octal
  set display+=lastline
  set autoread
  set sessionoptions-=options
  set viewoptions-=options
  set shortmess-=S
  set shortmess+=F

  " to set CursorLineNr highlight in vanilla vim
  " Ref: https://vi.stackexchange.com/a/24914
  if exists('+cursorlineopt')
    set cursorline
    set cursorlineopt=number
  endif

  if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " delete comment character when joining commented lines
  endif

  " check if there's termwinkey variable or not
  if exists('&termwinkey') | set termwinkey=<C-p> | endif
endif

if has('syntax')  | syntax on                 | endif
if has('autocmd') | filetype plugin indent on | endif
