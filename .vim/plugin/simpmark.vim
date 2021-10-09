" map dm to delete mark
nnoremap <silent> dm :call simp#delmark()<CR>

" map m to add mark
nnoremap <silent> m :call simp#addmark()<CR>

" jump to any mark with space j
nnoremap <leader><Space> :call simp#gotomark()<CR>
