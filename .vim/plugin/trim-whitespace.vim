" trim extra whitespace at the end of line

augroup no_trailing_whitespace
  autocmd!
  " Note: do not trim whitespace in viminfo file, it's dangerous!
  autocmd BufWritePre *
        \ if get(
        \   b:,
        \   'trim_trailing_whitespace',
        \   get(g:, 'trim_trailing_whitespace', 1)
        \ )
        \ && expand('<afile>') !=# 'viminfo' |
        \   let b:save = winsaveview() |
        \   keepjumps keeppatterns %s/\s\+$//e   |
        \   call winrestview(b:save)   |
        \   unlet b:save |
        \ endif
augroup END
