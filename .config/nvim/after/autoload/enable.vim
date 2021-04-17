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
