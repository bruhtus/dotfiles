" goyo plugin mapping

" set goyo by typing space + g
nnoremap <silent> <leader>g :Goyo<CR>

" limelight and vim-pencil integration with goyo
function! s:goyo_enter()
	autocmd InsertEnter * norm zz
	Limelight  | SoftPencil | set showmode
endfunction

function! s:goyo_leave()
	autocmd! InsertEnter *
	Limelight! | NoPencil   | set noshowmode | hi StatusLine ctermfg=233 guifg=#121212 | hi StatusLineTerm ctermfg=233 guifg=#121212
endfunction

autocmd User GoyoEnter call <SID>goyo_enter()
autocmd User GoyoLeave call <SID>goyo_leave()
