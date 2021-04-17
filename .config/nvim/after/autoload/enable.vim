function! enable#goyo()
	if !exists(':Goyo')
		echo 'Goyo plugin not loaded'
	else
		Goyo
	endif
endfunction

function! enable#rainbow()
	let g:rainbow_active = 0
	if !exists(':RainbowToggle')
		echo 'Rainbow plugin not loaded'
	else
		RainbowToggle
	endif
endfunction

function! enable#linediff()
	let g:linediff_buffer_type = 'scratch'
	let g:linediff_first_buffer_command  = 'enew'
	let g:linediff_further_buffer_command = 'new'
endfunction

function! enable#peek()
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
