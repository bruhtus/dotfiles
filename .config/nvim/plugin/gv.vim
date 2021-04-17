" gv.vim plugin config (to check git commit in vim)
" check also after/autoload directory

nnoremap <leader>b :call enable#gv#normal()<CR>
vnoremap <leader>b :<C-u>call enable#gv#visual()<CR>
