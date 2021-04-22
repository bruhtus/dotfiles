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

function! enable#fugitive()
	try
		packadd vim-fugitive
		Git
	catch
		echo 'Fugitive plugin not installed'
	endtry
endfunction

function! enable#filebeagle()
	let g:filebeagle_suppress_keymaps = 1
	if !exists(':FileBeagleBufferDir')
		try
			packadd vim-filebeagle
			FileBeagleBufferDir
		catch
			echo 'Filebeagle plugin not installed'
		endtry
	else
		FileBeagleBufferDir
	endif
endfunction

function! enable#easyalign()
	try
		packadd vim-easy-align

		" Start interactive EasyAlign in visual mode (e.g. vipgl)
		xmap gl <Plug>(EasyAlign)

		" Start interactive EasyAlign for a motion/text object (e.g. glip)
		nmap gl <Plug>(EasyAlign)
	catch
		echo 'Easy-align plugin not installed'
	endtry
endfunction
