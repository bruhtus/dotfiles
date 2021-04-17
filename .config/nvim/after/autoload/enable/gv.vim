function! enable#gv#normal()
	if !exists(':GV')
		echo 'Gv plugin not loaded'
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
		echo 'Gv plugin not loaded'
	else
		'<,'>GV
	endif
endfunction
