" colorscheme config (require seoul256mod.vim colorscheme)

try
  colo seoul256mod

  " https://vi.stackexchange.com/a/30989/34851
  " disable termguicolors in tty
  if $TERM != 'linux' && has('termguicolors')
    " Ref: https://github.com/tmux/tmux/issues/1246
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif

  " change statusline color when enter terminal emulator in neovim
  " if has('nvim')
  " 	autocmd! TermEnter * setlocal winhighlight=StatusLine:StatusLineTerm
  " 	autocmd! TermLeave * setlocal winhighlight=StatusLine:StatusLine
  " endif

catch /^Vim\%((\a\+)\)\=:E185/
  echo 'Seoul256mod colorscheme not found'

endtry
