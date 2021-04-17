function! peek#load()
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
