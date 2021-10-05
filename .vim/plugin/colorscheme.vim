" colorscheme config (require seoul256mod.vim colorscheme)

try
  colo seoul256mod

  " Ref: https://groups.google.com/g/vim_use/c/SNVPt60d0-c/m/F346-XjX8HMJ
  " disable termguicolors in tty (even when using tmux in tty)
  " TODO(minor): figure out how to update env variable in tmux
  " Note: there's `g:terminal_ansi_colors` that can change the default color
  " of vanilla vim terminal emulator
  " if exists('$DISPLAY') && has('termguicolors')
  "   " Ref: https://github.com/tmux/tmux/issues/1246
  "   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  "   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  "   set termguicolors
  " endif

  " change statusline color when enter terminal emulator in neovim
  " if has('nvim')
  " 	autocmd! TermEnter * setlocal winhighlight=StatusLine:StatusLineTerm
  " 	autocmd! TermLeave * setlocal winhighlight=StatusLine:StatusLine
  " endif

catch /^Vim\%((\a\+)\)\=:E185/
  echo 'Seoul256mod colorscheme not found'

endtry
