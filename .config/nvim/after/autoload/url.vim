function! url#open()
	let s:url = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
	echo s:url
	if s:url != ""
		silent exec "!xdg-open '".s:url."'"
	else
		echo "No URL found in line."
	endif
endfunction
