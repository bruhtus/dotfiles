function! HandleURL()
	let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
	echo s:uri
	if s:uri != ""
		silent exec "!xdg-open '".s:uri."'"
	else
		echo "No URL found in line."
	endif
endfunction

noremap gx :call HandleURL()<cr>
