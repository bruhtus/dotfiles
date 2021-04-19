" preview markdown with `glow` (on AUR)

let maplocalleader = '\'

" \\ to preview markdown
if executable('glow')
	if has('nvim')
		nnoremap <buffer> <localleader>\ :term glow -p %<CR>
	else
		nnoremap <buffer> <localleader>\ :!glow -p %<CR><CR>
	endif
endif
