" horisontal or vertical split buffer
function! SplitBuffer()
	let l:choice = confirm("Horisontal or Vertical Split Buffer?",
				\	"&JHorisontal\n&KVertical")

	if l:choice == 1
		echo 'Horisontal split (only one buffer)'
		ls
		call inputsave()
		let l:buffernumber = input('Enter buffer number: ')
		call inputrestore()
		if !empty(l:buffernumber)
			call execute("sb " . l:buffernumber)
		endif

	elseif l:choice == 2
		echo 'Vertical split (only one buffer)'
		ls
		call inputsave()
		let l:buffernumber = input('Enter buffer number: ')
		call inputrestore()
		if !empty(l:buffernumber)
			call execute("vert sb " . l:buffernumber)
		endif

	endif
endfunction

nnoremap <leader>h :call SplitBuffer()<CR>
