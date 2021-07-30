if has('nvim-0.5')
	nnoremap <silent> <leader>k :packadd hop.nvim \| HopWord<CR>
else
	let g:EasyMotion_do_mapping = 0
	nmap <silent> <leader>k :packadd vim-easymotion<CR><Plug>(easymotion-bd-w)
endif
