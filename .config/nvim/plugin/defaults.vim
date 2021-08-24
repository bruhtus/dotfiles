" default (n)vim settings

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
set wildmode=longest:full,full
set wildignore=*/.git/*,*.pdf,*.jpg,*jpeg,*.png,*.epub,*.mobi

" Ref: https://vi.stackexchange.com/a/28017/34851
set autoindent
set softtabstop=-69
set shiftwidth=2
set shiftround

" automatically setlocal expandtab, smarttab, tabstop, and shiftwidth depending on
" whether there's a tab character or not
" Ref: https://github.com/itchyny/dotfiles/blob/a7d5f94d794554c7a4eee68b3248c862b67abb14/.vimrc#L89
augroup defaults_tab
  autocmd!
  autocmd BufEnter *
        \ execute 'setlocal '
        \ . (search('^\t', 'n') && !search('^  ', 'n') ? 'noexpandtab nosmarttab tabstop=2' :
        \ search('^\t', 'n') && search('^  ', 'n') ? 'noexpandtab smarttab' :
        \ 'expandtab smarttab')
augroup END

set nobackup
set noshowmode
set noswapfile
set nostartofline

set ignorecase
set smartcase
set incsearch
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" in case I don't want to use statusline
if &ruler | set rulerformat=%-13.(%r%m%)\ %P | endif

if has('nvim')
  set guicursor=
  set nohlsearch
  set nosmarttab
  set noautoindent
  set inccommand=split

  augroup TermBuffer
    autocmd!
    autocmd TermOpen term://*
          \ setlocal nonumber norelativenumber signcolumn=no |
          \ startinsert
  augroup END

else
  set viminfo+=n~/.cache/vim/viminfo
  set belloff=all
  set backspace=indent,eol,start
  set complete-=i " disable scanning current and included files
  set nrformats-=octal
  set display+=lastline
  set autoread
  set sessionoptions-=options sessionoptions+=globals
  set viewoptions-=options
  set shortmess-=S
  set shortmess+=F
  set nolangremap
  set langnoremap

  " to set CursorLineNr highlight in vanilla vim
  " Ref: https://vi.stackexchange.com/a/24914
  if exists('+cursorlineopt')
    set cursorline
    set cursorlineopt=number
  endif

  if exists('+wildmenu')
    set wildmenu
  endif

  if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " delete comment character when joining commented lines
  endif

  " check if there's termwinkey variable or not
  if exists('&termwinkey') | set termwinkey=<C-p> | endif
endif

if has('syntax')  | syntax on                 | endif
if has('autocmd') | filetype plugin indent on | endif
