if has('nvim-0.5')
  nnoremap <silent> <leader>k m':<C-u>packadd hop.nvim \| HopWord<CR>
else
  let g:EasyMotion_do_mapping = 0
  nmap <silent> <leader>k m':<C-u>packadd vim-easymotion<CR><Plug>(easymotion-bd-w)
endif
