if has('nvim-0.5')
	nnoremap <silent> <leader>k :HopWord<CR>
else
	let g:EasyMotion_do_mapping = 0
	nmap <leader>k <Plug>(easymotion-bd-w)
endif
