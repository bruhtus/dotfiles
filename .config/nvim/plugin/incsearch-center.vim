" make incsearch appear in the middle
augroup VimIncsearch
	autocmd!
	autocmd CmdlineEnter /,\? :setlocal scrolloff=999
	autocmd CmdlineLeave /,\? :setlocal scrolloff=-1
	" autocmd CmdlineEnter /,\? :setlocal scrolloff=999 | cnoremap <CR> <CR>zz | redraw
	" autocmd CmdlineLeave /,\? :setlocal scrolloff=-1 | cunmap <CR>
augroup END
