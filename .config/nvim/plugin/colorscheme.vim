" colorscheme config

let g:seoul256_background = 233

silent! colo seoul256

augroup CustomColor
	autocmd!
	autocmd ColorScheme * hi Pmenu ctermbg=187 ctermfg=233
	autocmd ColorScheme * hi Pmenusel ctermbg=58 ctermfg=187
augroup END
