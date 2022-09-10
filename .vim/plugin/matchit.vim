finish
" use matchit to rotate between conflict marker
" Ref: https://stackoverflow.com/a/71676129
augroup conflict_setup
  autocmd!
  autocmd VimEnter * nested
        \ if &diff && winnr('$') == 3 && argc() == 3 |
        \   let b:match_words = '<<<<<<<:=======:>>>>>>>' |
        \ endif
augroup END
