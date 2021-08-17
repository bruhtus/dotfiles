" Vim-fugitive plugin config

if has('nvim')
  nnoremap <silent> <C-Space> :call enable#fugitive()<CR>
else
  nnoremap <silent> <C-@> :call enable#fugitive()<CR>
endif
