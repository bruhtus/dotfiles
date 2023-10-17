" disable netrw but autoload it for `gx`
" Ref: https://github.com/justinmk/config/blob/master/.config/nvim/init.vim#L55-L57

" let g:loaded_netrw             = 1 " $VIMRUNTIME/autoload/netrw.vim
let g:loaded_netrwPlugin       = 0 " $VIMRUNTIME/plugin/netrwPlugin.vim
let g:loaded_netrwFileHandlers = 1 " $VIMRUNTIME/autoload/netrwFileHandlers.vim
let g:loaded_netrwSettings     = 1 " $VIMRUNTIME/autoload/netrwSettings.vim
" let g:loaded_netrwSettings     = 1
" let g:loaded_netrwFileHandlers = 1

" let g:netrw_dirhistmax = 0
" let g:netrw_altfile = 1 " keep currently edited buffer as alternate file.
" let g:netrw_banner = 0
" let g:netrw_fastbrowse = 0
" let g:netrw_preview = 1
" let g:netrw_alto = 0
" let g:netrw_liststyle= 3
" let g:netrw_hide = 1
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

nnoremap gx :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())<CR>
