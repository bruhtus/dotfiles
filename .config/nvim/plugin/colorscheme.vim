" colorscheme config (require seoul256mod.vim colorscheme)

try
	colo seoul256mod

	function! InsertStatuslineColor(mode)
		if a:mode == 'i'
			hi StatusLine ctermfg=233 ctermbg=151
		elseif a:mode == 'r'
			hi StatusLine ctermfg=233 ctermbg=158
		else
			hi StatusLine ctermfg=233 ctermbg=153
		endif
	endfunction

	" change statusline color when enter insert mode
	autocmd! InsertEnter * call InsertStatuslineColor(v:insertmode)
	autocmd! InsertLeave * hi StatusLine ctermfg=233 ctermbg=187

	" change statusline color when enter terminal emulator in neovim
	if has('nvim')
		autocmd! TermEnter * setlocal winhighlight=StatusLine:StatusLineTerm
		autocmd! TermLeave * setlocal winhighlight=StatusLine:StatusLine
	endif

catch /^Vim\%((\a\+)\)\=:E185/
	echo 'Seoul256mod colorscheme not found'

endtry
