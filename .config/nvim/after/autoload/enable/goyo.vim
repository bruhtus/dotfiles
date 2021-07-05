" limelight and vim-pencil integration with goyo

function! enable#goyo#enter()
	autocmd! InsertEnter * norm zz
	autocmd! InsertLeave *
	silent! Limelight  | SoftPencil | set showmode
endfunction

function! enable#goyo#leave()
	silent! Limelight! | NoPencil   | set noshowmode
endfunction
