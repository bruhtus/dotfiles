" disable netrw but autoload it for `gx`
" reference: https://github.com/justinmk/config/blob/master/.config/nvim/init.vim#L55-L57

" let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 0
" let g:loaded_netrwSettings     = 1
" let g:loaded_netrwFileHandlers = 1

nnoremap gx :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())<CR>
