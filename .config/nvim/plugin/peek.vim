" print the content of the line without actually
" go to the line
" check also after/autoload/enable.vim

command! Peek call enable#peek()

" for more info h \%l
" set incsearch
" nnoremap <silent> ]<BS> /\%l<left>
