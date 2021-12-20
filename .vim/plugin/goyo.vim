" goyo plugin mapping
" check also after/autoload directory

" set goyo by typing space + g
nnoremap <silent> <leader>g :call enable#goyo()<CR>

augroup goyo_autocmd
  autocmd!
  autocmd User GoyoEnter call enable#goyo#enter()
  autocmd User GoyoLeave call enable#goyo#leave()
augroup END
