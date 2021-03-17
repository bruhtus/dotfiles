" trim extra whitespace at the end of line

function! TrimWhiteSpace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfunction

augroup no_trailing_whitespace
	autocmd!
	autocmd BufWritePre * :call TrimWhiteSpace()
augroup END
