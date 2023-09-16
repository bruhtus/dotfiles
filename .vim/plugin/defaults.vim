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
set spelllang=en_us spellfile=~/.vim/spell/en.utf-8.add
" set number relativenumber numberwidth=5 signcolumn=yes

set grepformat=%f:%l:%c:%m,%f
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

" to set CursorLineNr highlight
" Ref: https://vi.stackexchange.com/a/24914
" Note: the `cursorlineopt` is (finally) appear in nvim 0.6
" if exists('+cursorlineopt') | set cursorline cursorlineopt=number | endif

if exists('+colorcolumn') | set colorcolumn= | endif

if exists('+wildmenu') | set wildmenu | endif
set wildignorecase
set wildmode=longest:full,full
set wildignore=*/.git/*,*.pdf,*.epub,*.mobi,*.png,*.jpg,*.JPG,*.jpeg,*.gif,*.mp4,*.xlsx,*.cbz,*.apk
" if has('patch-8.2.4655') | set wildoptions=pum | endif

" check if there's termwinkey variable or not
if exists('+termwinkey') | set termwinkey=<C-p> | endif

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

" Note:
" - this function doesn't acknowledge people that use one space as indentation.
" - the result is the line number, not the total.
" let result = searchcount(#{pattern: '\t\+ \+', maxcount: -69})
function! s:detect_indent() abort
  " Note: skip the highlight with these name.
  let l:skip_patterns = "synIDattr(synID(line('.'), 1, 1), 'name') =~#"
        \ . "'\a*Comment\\|markdownCode\\|shHereDoc'"

  let b:indent_spaces = search('^  \+', 'nw')
  let b:indent_tabs = search('^\t', 'nw')
  let b:indent_tab_with_space = search('\t\+ \+', 'nw', 0, 0, l:skip_patterns)
  let b:indent_space_with_tab = search(' \+\t\+', 'nw', 0, 0, l:skip_patterns)
endfunction

function! s:use_editorconfig() abort
  if &ft =~# 'git*'
    return
  endif

  if expand('%:p') =~# '\v(fugitive|scp)://.*'
    return
  endif

  " Note: only use editorconfig in normal buffer
  if !empty(&buftype)
    return
  endif

  if !exists('b:editorconfig_path')
    " Ref: `:h file-searching` (the upward stop directory example didn't work)
    " Note:
    " have no idea how to use upward search stop directory,
    " so start search from current file directory upward until root directory.
    let l:editorconfig_file = findfile('.editorconfig', '.;')

    let b:editorconfig_path = !empty(l:editorconfig_file) ?
          \ fnamemodify(l:editorconfig_file, ':p') : ''

    " Note: make sure we can read the editorconfig file.
    if filereadable(b:editorconfig_path)
      call editorconfig#init(b:editorconfig_path)
      let b:editorconfig_enabled = 1
      return 1
    endif
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
  if !s:use_editorconfig()
    execute 'let '
          \ b:indent_tabs && !b:indent_spaces && !b:indent_tab_with_space
          \   && !b:indent_space_with_tab ?
          \ '[&l:ts, &l:et] = [&sw, 0]' :
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
  autocmd BufNewFile,BufRead,FileType *
        \ call s:detect_indent() |
        \ call s:set_indent()

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
  if !isdirectory(expand('~/.local/share/vim'))
    call mkdir(expand('~/.local/share/vim'))
  endif
  set viminfo+=n~/.local/share/vim/viminfo
endif

if has('syntax')  | syntax on                 | endif
if has('autocmd') | filetype plugin indent on | endif
