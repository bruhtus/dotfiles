" colorscheme config (require seoul256.vim plugin)

let g:seoul256_background = 233

try
	colo seoul256

	augroup CustomColor
		autocmd!
		autocmd ColorScheme * hi Pmenu ctermbg=236 ctermfg=187
		autocmd ColorScheme * hi Pmenusel ctermbg=250 ctermfg=233
		autocmd ColorScheme * hi StatusLine ctermfg=233 guifg=#121212
		autocmd ColorScheme * hi StatusLineTerm ctermfg=233 guifg=#121212
		autocmd ColorScheme * hi User1 cterm=bold ctermfg=187 ctermbg=233
		autocmd ColorScheme * hi EasyMotionTarget ctermbg=none ctermfg=lightgreen
		autocmd ColorScheme * hi EasyMotionTarget2First ctermbg=none ctermfg=lightred
		autocmd ColorScheme * hi EasyMotionTarget2Second ctermbg=none ctermfg=red
	augroup END

	function! InsertStatuslineColor(mode)
		if a:mode == 'i'
			hi StatusLine ctermfg=233 ctermbg=153
		elseif a:mode == 'r'
			hi StatusLine ctermfg=233 ctermbg=158
		else
			hi StatusLine ctermfg=233 ctermbg=153
		endif
	endfunction

	autocmd! InsertEnter * call InsertStatuslineColor(v:insertmode)
	autocmd! InsertLeave * hi StatusLine ctermfg=233 ctermbg=187

catch /^Vim\%((\a\+)\)\=:E185/
	echo 'Seoul256 colorscheme not found'

endtry
