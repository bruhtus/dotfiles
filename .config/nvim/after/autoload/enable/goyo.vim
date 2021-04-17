" limelight and vim-pencil integration with goyo

function! enable#goyo#enter()
	autocmd! InsertEnter * norm zz
	autocmd! InsertLeave *
	silent! Limelight  | SoftPencil | set showmode
endfunction

function! enable#goyo#leave()
	autocmd! InsertEnter * call InsertStatuslineColor(v:insertmode)
	autocmd! InsertLeave * hi StatusLine ctermfg=233 ctermbg=187
	silent! Limelight! | NoPencil   | set noshowmode
endfunction
