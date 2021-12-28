" default (n)vim settings

set title titlestring=%t " check `:h 'statusline'` for the flags

set hidden
set autoread
set linebreak
set belloff=all
set backspace=2
set laststatus=2
set history=10000
set complete-=t,i " disable scanning tags and included files
set winminheight=0
set matchpairs+=<:>
set nrformats-=octal
set display+=lastline
set virtualedit=block
set ttyfast lazyredraw
set viewoptions-=options
set splitbelow splitright
set nolangremap langnoremap
set shortmess-=S shortmess+=F
set number relativenumber numberwidth=5

set completeopt-=preview " ignore omni complete description
set completeopt+=noinsert completeopt+=noselect completeopt+=menuone

set showmode showcmd
set ignorecase smartcase incsearch
set nobackup noswapfile nostartofline
set updatetime=0 timeoutlen=500 ttimeoutlen=30
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" to make vim session use absolute path, remove curdir option
set sessionoptions-=options sessionoptions-=curdir sessionoptions+=globals

" to set CursorLineNr highlight
" Ref: https://vi.stackexchange.com/a/24914
" Note: the `cursorlineopt` is (finally) appear in nvim 0.6
if exists('+cursorlineopt') | set cursorline cursorlineopt=number | endif

if exists('+wildmenu') | set wildmenu | endif
set wildignorecase
set wildmode=longest:full,full
set wildignore=*/.git/*,*.pdf,*.jpg,*jpeg,*.png,*.epub,*.mobi

" check if there's termwinkey variable or not
if exists('+termwinkey') | set termwinkey=<C-p> | endif

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j " delete comment character when joining commented lines
endif

" in case I don't want to use statusline
" if &ruler | set rulerformat=%-13.(%r%m%)\ %P | endif
if &ruler | set rulerformat=%-13.(%l/%<%L:%c%)\ %P | endif

" Ref: https://vi.stackexchange.com/a/28017/34851
set autoindent shiftround smarttab shiftwidth=2 softtabstop=-69

" automatically setlocal expandtab and tabstop depending on
" whether there's a tab character or not
" Ref: https://github.com/itchyny/dotfiles/blob/a7d5f94d794554c7a4eee68b3248c862b67abb14/.vimrc#L89
" Ref: https://github.com/luochen1990/indent-detector.vim/blob/master/plugin/indent_detector.vim
" Ref: https://stackoverflow.com/a/35968022
" Ref: http://vimregex.com/#anchors
" Ref: `:h :let-option`, `:h :let-unpack`
" Note: this autocmd doesn't acknowledge people that use one space as
" indentation.
" Note: the result is the line number, not the total.
" let result = searchcount(#{pattern: '\t\+ \+', maxcount: -69})
augroup indent_detection
  autocmd!
  autocmd BufNewFile,BufRead,FileType *
        \ let b:indent_spaces = search('^  \+', 'nW') |
        \ let b:indent_tabs = search('^\t', 'nW') |
        \ let b:tab_with_space = search('\t\+ \+', 'nW') |
        \ let b:space_with_tab = search(' \+\t\+', 'nW') |
        \ execute 'let '
        \ b:indent_tabs && !b:indent_spaces && !b:tab_with_space && !b:space_with_tab ?
        \ '[&l:ts, &l:et] = [&sw, 0]' :
        \ (b:indent_tabs && b:indent_spaces) || b:tab_with_space || b:space_with_tab ?
        \ '&l:et = 0' :
        \ '&l:et = 1'
augroup END

" set infercase
" set nrformats+=alpha " add aplhabet in increment/decrement

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
endif

if has('syntax')  | syntax on                 | endif
if has('autocmd') | filetype plugin indent on | endif
