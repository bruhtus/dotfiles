" print the content of the line without actually
" go to the line
function! PeekLine()
	norm m`
	call inputsave()
	let l:linenumber = input('Enter line number: ')
	call inputrestore()
	" remove annoying Enter line number
	redraw
	" do nothing if the line number doesn't exist
	" don't be stupid
	if l:linenumber <= line('$')
		execute l:linenumber . "p"
	endif
	norm ``
endfunction

command! Peek call PeekLine()

" for more info h \%l
" set incsearch
" nnoremap <silent> ]<BS> /\%l<left>
