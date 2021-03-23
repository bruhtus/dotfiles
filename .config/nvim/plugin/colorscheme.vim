" colorscheme config (require seoul256.vim plugin)

let g:seoul256_background = 233

try
	colo seoul256

	augroup CustomColor
		autocmd!
		autocmd ColorScheme * hi Pmenu ctermbg=235 ctermfg=187
		autocmd ColorScheme * hi Pmenusel ctermbg=253 ctermfg=233
		autocmd ColorScheme * hi StatusLine ctermfg=233 guifg=#121212
		autocmd ColorScheme * hi StatusLineTerm ctermfg=233 guifg=#121212
		autocmd ColorScheme * hi EasyMotionTarget ctermbg=none ctermfg=lightgreen
		autocmd ColorScheme * hi EasyMotionTarget2First ctermbg=none ctermfg=lightred
		autocmd ColorScheme * hi EasyMotionTarget2Second ctermbg=none ctermfg=red
	augroup END

catch /^Vim\%((\a\+)\)\=:E185/
	echo 'Seoul256 colorscheme not found'

endtry
