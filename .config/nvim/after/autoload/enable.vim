function! enable#goyo()
	if !exists(':Goyo')
		try
			packadd vim-pencil | packadd goyo.vim | packadd limelight.vim
			Goyo
		catch
			echo 'Goyo, limelight, and vim-pencil plugin not installed'
		endtry
	else
		Goyo
	endif
endfunction

function! enable#rainbow()
	let g:rainbow_active = 0
	if !exists(':RainbowToggle')
		try
			packadd rainbow
			RainbowToggle
		catch
			echo 'Rainbow plugin not installed'
		endtry
	else
		RainbowToggle
	endif
endfunction

function! enable#linediff()
	try
		packadd linediff.vim
		let g:linediff_buffer_type = 'scratch'
		let g:linediff_first_buffer_command  = 'enew'
		let g:linediff_further_buffer_command = 'new'
	catch
		echo 'Linediff plugin not installed'
	endtry
endfunction
