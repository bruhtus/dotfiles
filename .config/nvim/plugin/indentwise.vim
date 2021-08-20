" vim-indentwise mapping

nmap <expr> <silent> [-
      \ (!exists('g:did_indentwise') ?
      \ ':<C-u>packadd vim-indentwise<CR>' : '')
      \ .. v:count1 . '<Plug>(IndentWisePreviousLesserIndent)'

nmap <expr> <silent> [=
      \ (!exists('g:did_indentwise') ?
      \ ':<C-u>packadd vim-indentwise<CR>' : '')
      \ .. v:count1 . '<Plug>(IndentWisePreviousEqualIndent)'

nmap <expr> <silent> [;
      \ (!exists('g:did_indentwise') ?
      \ ':<C-u>packadd vim-indentwise<CR>' : '')
      \ .. v:count1 . '<Plug>(IndentWisePreviousGreaterIndent)'

nmap <expr> <silent> ]-
      \ (!exists('g:did_indentwise') ?
      \ ':<C-u>packadd vim-indentwise<CR>' : '')
      \ .. v:count1 . '<Plug>(IndentWiseNextLesserIndent)'

nmap <expr> <silent> ]=
      \ (!exists('g:did_indentwise') ?
      \ ':<C-u>packadd vim-indentwise<CR>' : '')
      \ .. v:count1 . '<Plug>(IndentWiseNextEqualIndent)'

nmap <expr> <silent> ];
      \ (!exists('g:did_indentwise') ?
      \ ':<C-u>packadd vim-indentwise<CR>' : '')
      \ .. v:count1 . '<Plug>(IndentWiseNextGreaterIndent)'
