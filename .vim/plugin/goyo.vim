" goyo plugin mapping
" check also after/autoload directory

" set goyo by typing space + g
nnoremap <silent> <leader>g :call enable#goyo()<CR>

autocmd! User GoyoEnter call enable#goyo#enter()
autocmd! User GoyoLeave call enable#goyo#leave()
