" trim extra whitespace at the end of line
" check after/autoload/whitespace.vim

augroup no_trailing_whitespace
  autocmd!
  autocmd BufWritePre *
        \ let b:save = winsaveview() |
        \ keeppatterns %s/\s\+$//e   |
        \ call winrestview(b:save)   |
        \ unlet b:save
augroup END
