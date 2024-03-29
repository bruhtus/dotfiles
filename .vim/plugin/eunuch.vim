" vim-eunuch is on opt directory (did not get loaded at startup by default)
" so, only load vim-eunuch when running these command
" to check if the command really remapped `:command`

command! -bang -bar Delete
      \ packadd vim-eunuch |
      \ Delete<bang>

command! -bar -nargs=+ -complete=file Rename
      \ packadd vim-eunuch |
      \ Rename <args>

command! -bar -nargs=? -complete=dir Mkdir
      \ packadd vim-eunuch |
      \ Mkdir <args>
