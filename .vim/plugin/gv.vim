" gv.vim plugin config (to check git commit in vim)
" check also after/autoload directory

nnoremap <silent> <leader>b :call enable#gv#normal()<CR>
xnoremap <silent> <leader>b :<C-u>call enable#gv#visual()<CR>
