" preview markdown with `glow` (on AUR)

let maplocalleader = '\'

" \\ to preview markdown
if has('nvim')
	autocmd BufRead,BufNewFile *.md nnoremap <buffer> <localleader>\ :term glow -p %<CR>
else
	autocmd BufRead,BufNewFile *.md nnoremap <buffer> <localleader>\ :!glow -p %<CR><CR>
endif
