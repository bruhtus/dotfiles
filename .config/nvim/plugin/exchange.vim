" mapping for vim-exchange plugin

" these are issue that i've found:
" if you use this kind of mapping, you can't use it with <C-o> while in insert
" mode. <C-o> gonna detect v:count1 and put the rest of the command in insert
" mode.
" this kind of mapping apparently can't use `G` range (until the end of the
" file)

nmap <expr> <silent> cx (!exists('g:loaded_exchange') ? ':<C-u>packadd vim-exchange <Bar> let g:loaded_exchange = 1<CR>' : '' ) . v:count1 . '<Plug>(Exchange)'
nmap <expr> <silent> cxx (!exists('g:loaded_exchange') ? ':<C-u>packadd vim-exchange <Bar> let g:loaded_exchange = 1<CR>' : '' ) . '<Plug>(ExchangeLine)'
