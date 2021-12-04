" default (n)vim settings

set title
set titlestring=%t " check `:h 'statusline'` for the flags

set hidden
set showcmd
set linebreak
set lazyredraw
set complete-=t " disable scanning tags
set laststatus=2
set updatetime=0
set history=10000
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
set autoindent shiftround smarttab shiftwidth=2 softtabstop=-69

" automatically setlocal expandtab and tabstop depending on
" whether there's a tab character or not
" Ref: https://github.com/itchyny/dotfiles/blob/a7d5f94d794554c7a4eee68b3248c862b67abb14/.vimrc#L89
" Ref: https://github.com/luochen1990/indent-detector.vim/blob/master/plugin/indent_detector.vim
" Ref: `:h :let-option`, `:h :let-unpack`
augroup indent_detection
  autocmd!
  autocmd BufNewFile,BufRead,FileType *
        \ execute 'let '
        \ search('^\t', 'n') && !search('^  ', 'n') ? '[&l:ts, &l:et] = [&sw, 0]' :
        \ search('^\t', 'n') && search('^  ', 'n') ? '&l:et = 0' :
        \ '&l:et = 1'
augroup END

set nobackup noshowmode noswapfile nostartofline
set ignorecase smartcase incsearch
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" to make vim session use absolute path, remove curdir option
set sessionoptions-=options sessionoptions-=curdir sessionoptions+=globals

" in case I don't want to use statusline
if &ruler | set rulerformat=%-13.(%r%m%)\ %P | endif

if has('nvim')
  set guicursor=
  set nohlsearch
  set noautoindent
  " set inccommand=nosplit

  " augroup term_buffer
  "   autocmd!
  "   autocmd TermOpen term://*
  "         \ setlocal nonumber norelativenumber signcolumn=no |
  "         \ startinsert
  " augroup END

else
  if !isdirectory(expand('~/.local/share/vim'))
    call mkdir(expand('~/.local/share/vim'))
  endif
  set viminfo+=n~/.local/share/vim/viminfo
  set belloff=all
  set backspace=indent,eol,start
  set complete-=i " disable scanning current and included files
  set nrformats-=octal
  set display+=lastline
  set autoread
  set viewoptions-=options
  set shortmess-=S shortmess+=F
  set nolangremap langnoremap

  " to set CursorLineNr highlight in vanilla vim
  " Ref: https://vi.stackexchange.com/a/24914
  if exists('+cursorlineopt') | set cursorline cursorlineopt=number | endif

  if exists('+wildmenu') | set wildmenu | endif

  " check if there's termwinkey variable or not
  if exists('+termwinkey') | set termwinkey=<C-p> | endif

  if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " delete comment character when joining commented lines
  endif
endif

if has('syntax')  | syntax on                 | endif
if has('autocmd') | filetype plugin indent on | endif
