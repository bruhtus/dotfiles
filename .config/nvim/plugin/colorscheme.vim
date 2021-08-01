" colorscheme config (require seoul256mod.vim colorscheme)

try
  colo seoul256mod

  " https://vi.stackexchange.com/a/30989/34851
  " disable termguicolors in tty
  if $TERM != 'linux'
    if has('termguicolors') | set termguicolors | endif
  endif

  " change statusline color when enter terminal emulator in neovim
  " if has('nvim')
  " 	autocmd! TermEnter * setlocal winhighlight=StatusLine:StatusLineTerm
  " 	autocmd! TermLeave * setlocal winhighlight=StatusLine:StatusLine
  " endif

catch /^Vim\%((\a\+)\)\=:E185/
  echo 'Seoul256mod colorscheme not found'

endtry
