" trim extra whitespace at the end of line

augroup no_trailing_whitespace
  autocmd!
  " Note: do not trim whitespace in viminfo file, it's dangerous!
  autocmd BufWritePre *
        \ if expand('<afile>') !=# 'viminfo' |
        \   let b:save = winsaveview() |
        \   keeppatterns %s/\s\+$//e   |
        \   call winrestview(b:save)   |
        \   unlet b:save |
        \ endif
augroup END
