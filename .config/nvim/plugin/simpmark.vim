" map dm to delete mark
nnoremap <silent> dm :call simp#markdelete()<CR>

" jump to any mark with space j
nnoremap <leader><Space> :call simp#gotomark()<CR>
