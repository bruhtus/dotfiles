" source: https://vi.stackexchange.com/a/8662/34851
"
" to match the Nth occurence, you can use `\zs` and `\{N}`
" example: `:s/\v(.{-}\zs<pattern>.){2}//`, it's gonna remove 2nd occurence of
" <pattern>
" More info: `:h \zs`

function! substitute#current_line#split_by_comma()
	try
		norm m`
		s/, /,\r/g
		norm =ip
		norm ``
	catch
		echo "There's no comma in current line"
	endtry
endfunction
