" map dm to delete mark
function! DeleteMark()
	" getchar() - prompts user for a single character and returns the chars
	" ascii representation
	" nr2char() - converts ASCII `NUMBER TO CHAR'

	let l:mark = nr2char(getchar())
	" remove the `press any key prompt'
	redraw

	" build a string which uses the `normal' command plus the var holding the
	" mark - then eval it.
	execute "silent! delm " . l:mark
endfunction

nnoremap <silent> dm :call DeleteMark()<CR>

" jump to any mark with space j
function! GoToMark()
	" only display mark [a-zA-Z], mark ', and mark .
	marks '.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
	echo('Mark: ')

	" getchar() - prompts user for a single character and returns the chars
	" ascii representation
	" nr2char() - converts ASCII `NUMBER TO CHAR'

	let l:mark = nr2char(getchar())
	" remove the `press any key prompt'
	redraw

	" build a string which uses the `normal' command plus the var holding the
	" mark - then eval it.
	execute "silent! normal! `" . l:mark
	norm zz
endfunction

nnoremap <leader>j :call GoToMark()<CR>
