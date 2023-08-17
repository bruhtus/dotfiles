nmap <silent> <leader>k <Plug>SneakLabel_s
xmap <silent> <leader>k <Plug>SneakLabel_s
omap <silent> z <Plug>SneakLabel_s

nmap <silent> <leader>j <Plug>SneakLabel_S
xmap <silent> <leader>j <Plug>SneakLabel_S
omap <silent> Z <Plug>SneakLabel_S

nmap <silent> <leader>; <Plug>Sneak_;
xmap <silent> <leader>; <Plug>Sneak_;
omap <silent> <leader>; <Plug>Sneak_;

nmap <silent> <leader>, <Plug>Sneak_,
xmap <silent> <leader>, <Plug>Sneak_,
omap <silent> <leader>, <Plug>Sneak_,

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
