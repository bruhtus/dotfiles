" colorscheme config (require seoul256mod.vim colorscheme)

try
	colo seoul256mod

	" change statusline color when enter insert mode
	autocmd! InsertEnter * hi StatusLine ctermfg=233 ctermbg=151
	autocmd! InsertLeave * hi StatusLine ctermfg=233 ctermbg=187

	" change statusline color when enter terminal emulator in neovim
	if has('nvim')
		autocmd! TermEnter * setlocal winhighlight=StatusLine:StatusLineTerm
		autocmd! TermLeave * setlocal winhighlight=StatusLine:StatusLine
	endif

catch /^Vim\%((\a\+)\)\=:E185/
	echo 'Seoul256mod colorscheme not found'

endtry
