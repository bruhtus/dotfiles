" Vim-fugitive plugin config

nnoremap <silent> Z<Space> :call enable#fugitive()<CR>

nnoremap <silent> <leader>b :call enable#fugitive_log#normal()<CR>
xnoremap <silent> <leader>b :<C-u>call enable#fugitive_log#visual()<CR>

" if has('nvim')
"   nnoremap <silent> <C-Space> :call enable#fugitive()<CR>
" else
"   nnoremap <silent> <C-@> :call enable#fugitive()<CR>
" endif
