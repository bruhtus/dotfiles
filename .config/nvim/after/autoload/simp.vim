" list, change, or delete buffer
function! simp#buf()
	let l:choice = confirm("List/Change/Delete Buffer(s)?",
				\	"&LList\n&JChange\n&KDelete")

	if l:choice == 1
		echo 'List buffer(s)'
		ls

	elseif l:choice == 2
		echo 'Change buffer'
		ls
		call inputsave()
		let l:buffernumber = input('Enter buffer number: ')
		call inputrestore()
		try
			if !empty(l:buffernumber)
				call execute("b " . l:buffernumber)
			endif
		catch
			redraw
			echo "Buffer doesn't exist"
		endtry

	elseif l:choice == 3
		echo 'Delete buffer(s)'
		ls
		call inputsave()
		let l:buffernumber = input('Enter buffer number: ')
		call inputrestore()
		try
			if !empty(l:buffernumber)
				call execute("bd " . l:buffernumber)
			endif
		catch
			redraw
			echo "Buffer doesn't exist"
		endtry

	endif
endfunction
