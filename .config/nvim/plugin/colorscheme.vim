" colorscheme config (require seoul256mod.vim colorscheme)

try
	colo seoul256mod

	" change statusline color when enter terminal emulator in neovim
	if has('nvim')
		autocmd! TermEnter * setlocal winhighlight=StatusLine:StatusLineTerm
		autocmd! TermLeave * setlocal winhighlight=StatusLine:StatusLine
	endif

catch /^Vim\%((\a\+)\)\=:E185/
	echo 'Seoul256mod colorscheme not found'

endtry
