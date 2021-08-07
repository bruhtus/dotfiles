if has('nvim-0.5')
  nnoremap <expr> <silent> <leader>k (!exists(':HopWord') ? "m':<C-u>packadd hop.nvim <Bar> " : "m':" ) . 'HopWord<CR>'
else
  let g:EasyMotion_do_mapping = 0
  nmap <expr> <silent> <leader>k (!exists('g:EasyMotion_loaded') ? "m':<C-u>packadd vim-easymotion<CR>" : '' ) . '<Plug>(easymotion-bd-w)'
endif
