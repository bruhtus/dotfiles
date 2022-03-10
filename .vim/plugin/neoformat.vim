let g:neoformat_try_node_exe = 1

augroup neoformat_on_save
  autocmd!
  autocmd BufWritePre *
        \ if &ft !~# '\v(gitcommit|vim|zsh|sh|diff)' |
        \   if (!exists('g:no_formatter'))           |
        \     Neoformat                              |
        \   endif                                    |
        \ endif
augroup END
