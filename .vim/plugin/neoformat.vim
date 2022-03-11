let g:neoformat_try_node_exe = 1

augroup neoformat_on_save
  autocmd!
  autocmd BufWritePre *
        \ if !exists('g:no_formatter') && exists(':Neoformat') |
        \   Neoformat                                          |
        \ endif                                                |
augroup END
