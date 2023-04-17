let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#target_labels = ';aszxcfvqwertyuiopbnmABCEFGIJKNOPQRSTUVZ'

nnoremap <expr> <silent> <leader>k
      \ (!exists('g:loaded_sneak_plugin') ? ":<C-u>packadd vim-sneak<CR>" : '' )
      \ . '<Plug>SneakLabel_s'

xnoremap <expr> <silent> <leader>k
      \ (!exists('g:loaded_sneak_plugin') ? ":<C-u>packadd vim-sneak<CR>gv" : '' )
      \ . '<Plug>SneakLabel_s'

nnoremap <expr> <silent> <leader>j
      \ (!exists('g:loaded_sneak_plugin') ? ":<C-u>packadd vim-sneak<CR>" : '' )
      \ . '<Plug>SneakLabel_S'

xnoremap <expr> <silent> <leader>j
      \ (!exists('g:loaded_sneak_plugin') ? ":<C-u>packadd vim-sneak<CR>gv" : '' )
      \ . '<Plug>SneakLabel_S'

nnoremap <expr> <silent> <leader>;
      \ (!exists('g:loaded_sneak_plugin') ? ":<C-u>packadd vim-sneak<CR>" : '' )
      \ . '<Plug>Sneak_;'

xnoremap <expr> <silent> <leader>;
      \ (!exists('g:loaded_sneak_plugin') ? ":<C-u>packadd vim-sneak<CR>gv" : '' )
      \ . '<Plug>Sneak_;'

nnoremap <expr> <silent> <leader>,
      \ (!exists('g:loaded_sneak_plugin') ? ":<C-u>packadd vim-sneak<CR>" : '' )
      \ . '<Plug>Sneak_,'

xnoremap <expr> <silent> <leader>,
      \ (!exists('g:loaded_sneak_plugin') ? ":<C-u>packadd vim-sneak<CR>gv" : '' )
      \ . '<Plug>Sneak_,'

" nnoremap <expr> <silent> <leader>k
"       \ (!exists('g:loaded_sneak_plugin') ?
"       \ "m':<C-u>let g:sneak#label = 1 <Bar>
"       \ let g:sneak#use_ic_scs = 1 <Bar>
"       \ let g:sneak#target_labels = ';aszxcfvqwertyuiopbnmABCEFGIJKNOPQRSTUVZ' <Bar>
"       \ packadd vim-sneak<CR>" : "m'" ) . ":<C-u>call sneak#wrap('', 2, 0, 2, 2)<CR>"

" nnoremap <expr> <silent> <leader>j
"       \ (!exists('g:loaded_sneak_plugin') ?
"       \ "m':<C-u>let g:sneak#label = 1 <Bar>
"       \ let g:sneak#use_ic_scs = 1 <Bar>
"       \ let g:sneak#target_labels = ';aszxcfvqwertyuiopbnmABCEFGIJKNOPQRSTUVZ' <Bar>
"       \ packadd vim-sneak<CR>" : "m'" ) . ":<C-u>call sneak#wrap('', 2, 1, 2, 2)<CR>"

" if has('nvim-0.5')
"   nnoremap <expr> <silent> <leader>k (!exists(':HopWord') ? "m':<C-u>packadd hop.nvim <Bar> " : "m':" ) . 'HopWord<CR>'
" else
"   let g:EasyMotion_do_mapping = 0
"   nmap <expr> <silent> <leader>k (!exists('g:EasyMotion_loaded') ? "m':<C-u>packadd vim-easymotion<CR>" : "m'" ) . '<Plug>(easymotion-bd-w)'
" endif
