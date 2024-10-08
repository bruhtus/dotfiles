" default (n)vim settings

set title titlestring=%t " check `:h 'statusline'` for the flags

set hidden
set mouse=
set autoread
set linebreak
set belloff=all
set backspace=2
set noautochdir
set laststatus=2
set history=10000
set winminwidth=0 " minimal line when making buffer full screen with ctrl-w|
set winminheight=0 " minimal line when making buffer full screen with ctrl-w_
set matchpairs+=<:>
set nrformats-=octal
set display+=lastline
set virtualedit=block
set ttyfast lazyredraw
set viewoptions-=options
set splitbelow splitright
set nolangremap langnoremap
set shortmess-=S shortmess+=F
set spelllang=en_us spellfile=$MYVIMDIR/spell/en.utf-8.add
" set number relativenumber numberwidth=5 signcolumn=yes

if executable('rg')
  set grepprg=rg\ --smart-case\ --hidden\ -H\ --line-number
elseif has('unix')
  set grepprg=grep\ -iHIrn
endif

set complete-=t,i " disable scanning tags and included files
set completeopt-=preview " ignore omni complete description
" set completeopt+=noinsert completeopt+=noselect completeopt+=menuone

set showmode showcmd cmdheight=1
set ignorecase smartcase incsearch
set nobackup noswapfile nostartofline
set updatetime=0 timeoutlen=500 ttimeoutlen=30

" Ref: https://en.wikipedia.org/wiki/Code_page_437
set list listchars=tab:\\u00ac\\u00b7,trail:\\u2022,extends:\\u25ba,precedes:\\u25c4,nbsp:\\u00b7
set fillchars=vert:\\u2502
if has('linebreak') | set showbreak=▲ | endif

" to make vim session use absolute path, remove curdir option
set sessionoptions-=blank sessionoptions-=options sessionoptions+=globals

" jumping to errors with quickfix command.
set switchbuf=uselast

" to set CursorLineNr highlight
" Ref: https://vi.stackexchange.com/a/24914
" Note: the `cursorlineopt` is (finally) appear in nvim 0.6
" if exists('+cursorlineopt') | set cursorline cursorlineopt=number | endif

if exists('+colorcolumn') | set colorcolumn= | endif

if exists('+wildmenu') | set wildmenu | endif
set wildignorecase
" set wildmode=longest:full,full
set wildignore=*/.git/*
" if has('patch-8.2.4655') | set wildoptions=pum | endif

" check if there's termwinkey variable or not
if exists('+termwinkey') | set termwinkey=<C-q> | endif

if exists('+undoreload') | set undoreload=0 | endif

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j " delete comment character when joining commented lines
endif

" Ref:
" https://teddit.net/r/vim/comments/5l939k/recommendation_deinvim_as_a_plugin_manager/
if exists('+guioptions') | set guioptions=M | endif

" in case I don't want to use statusline
" if &ruler | set rulerformat=%-13.(%r%m%)\ %P | endif
" if &ruler | set rulerformat=%-13.(%l/%<%L:%c%)\ %P | endif
if &ruler | set rulerformat=%l:%c%=%P| endif

" Ref: https://vi.stackexchange.com/a/28017/34851
set autoindent shiftround smarttab shiftwidth=2 softtabstop=-69

function! s:no_set_indent() abort
  let l:large_file = 100 * 1024 * 1024

  " Note: prevent detect and set indent if file size is more than 100 mb
  if getfsize(expand('<afile>')) >= l:large_file
    return 1
  endif

  if @% =~# '^filebeagle\|.*\.csv\|.*\.go'
    return 1
  endif

  if &ft =~# '^git\|^netrw'
    return 1
  endif
endfunction

" Note:
" - this function doesn't acknowledge people that use one space as indentation.
" - the result is the line number, not the total.
" let result = searchcount(#{pattern: '\t\+ \+', maxcount: -69})
function! s:detect_indent() abort
  if s:no_set_indent()
    return
  endif

  " Note: skip the highlight with these name.
  let l:skip_patterns = "synIDattr(synID(line('.'), 1, 1), 'name') =~#"
        \ . "'\a*Comment\\|markdownCode\\|shHereDoc'"

  let b:indent_spaces = search('^  \+', 'nw')
  let b:indent_tabs = search('^\t', 'nw')
  let b:indent_tab_with_space = search('\t\+ \+', 'nw', 0, 0, l:skip_patterns)
  let b:indent_space_with_tab = search(' \+\t\+', 'nw', 0, 0, l:skip_patterns)

  let b:indent_info = join(
        \   [
        \     "First line indent space: " . b:indent_spaces,
        \     "First line indent tab: " . b:indent_tabs,
        \     "First line tab with space: " . b:indent_tab_with_space,
        \     "First line space with tab: " . b:indent_space_with_tab,
        \   ],
        \   "\n"
        \ )

  return 1
endfunction

" Ref: https://spec.editorconfig.org/
" Note: prioritize default vim filetype indentation over editorconfig.
function! s:use_editorconfig() abort
  " do not use set indent and editorconfig in `fugitive://.*`, `scp://.*`,
  " or any filename that start with `<alphabet>:`.
  if @% =~# '^\a\+:\|^/tmp/'
    return
  endif

  " only use editorconfig in normal buffer.
  if !empty(&buftype)
    return
  endif

  if !exists('b:editorconfig_enabled')
    call editorconfig#init()
    command! EditorconfigReload call editorconfig#init()
  endif

  return
endfunction

" automatically setlocal expandtab and tabstop depending on
" whether there's a tab character or not
" Ref:
" - https://github.com/itchyny/dotfiles/blob/a7d5f94d794554c7a4eee68b3248c862b67abb14/.vimrc#L89
" - https://github.com/luochen1990/indent-detector.vim/blob/master/plugin/indent_detector.vim
" - https://stackoverflow.com/a/35968022
" - http://vimregex.com/#anchors
" - `:h :let-option`, `:h :let-unpack`
function! s:set_indent() abort
  if !s:detect_indent()
    return
  endif

  if !s:use_editorconfig()
    execute 'let '
          \ b:indent_tabs && !b:indent_spaces && !b:indent_tab_with_space
          \   && !b:indent_space_with_tab ?
          \ '[&l:ts, &l:et] = [&g:sw, 0]' :
          \ (b:indent_tabs && b:indent_spaces) || b:indent_tab_with_space
          \   || b:indent_space_with_tab ?
          \ '[&l:ts, &l:et] = [&g:ts, 0]' :
          \ '&l:et = 1'
  endif
endfunction

augroup indentation
  autocmd!
  " Note: because using BufRead instead of BufEnter, the setting is only set
  " once, when reading a file into the buffer. why didn't use BufEnter then?
  " so that we didn't overwrite modeline. modeline was set before BufEnter.
  autocmd BufNewFile,BufRead,FileType * call s:set_indent()
  autocmd BufWritePost * call s:detect_indent()
augroup END

" set infercase
" set nrformats+=alpha " add alphabet in increment/decrement

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
  if !isdirectory($XDG_STATE_HOME . '/vim')
    call mkdir($XDG_STATE_HOME . '/vim', 'p')
  endif
  set viminfo+=n$XDG_STATE_HOME/vim/viminfo
endif

if has('syntax')  | syntax on                 | endif
if has('autocmd') | filetype plugin indent on | endif
