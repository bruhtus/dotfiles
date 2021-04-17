function! enable#goyo()
	if !exists(':Goyo')
		echo 'Goyo plugin not loaded'
	else
		Goyo
	endif
endfunction
