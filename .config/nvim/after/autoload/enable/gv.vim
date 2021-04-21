function! enable#gv#normal()
	if !exists(':GV')
		try
			packadd vim-fugitive | packadd gv.vim

			let l:choice = confirm("Current file git commit(s) or All git commit(s)?",
						\	"&JCurrent\n&KAll")
			if l:choice == 1
				GV!
			elseif l:choice == 2
				GV
			endif
		catch
			echo 'Fugitive and gv plugin not installed'
		endtry
	else
		let l:choice = confirm("Current file git commit(s) or All git commit(s)?",
					\	"&JCurrent\n&KAll")
		if l:choice == 1
			GV!
		elseif l:choice == 2
			GV
		endif
	endif
endfunction

function! enable#gv#visual()
	if !exists(':GV')
		try
			packadd vim-fugitive | packadd gv.vim
			'<,'>GV
		catch
			echo 'Fugitive and gv plugin not installed'
		endtry

	else
		'<,'>GV
	endif
endfunction
