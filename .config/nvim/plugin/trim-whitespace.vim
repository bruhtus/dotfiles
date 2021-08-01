" trim extra whitespace at the end of line
" check after/autoload/whitespace.vim

augroup no_trailing_whitespace
  autocmd!
  autocmd BufWritePre * :call whitespace#trim()
augroup END
