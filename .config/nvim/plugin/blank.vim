" map Z<Space> to enter blank space below and ZB to enter blank space above
" check after/autoload/blank.vim

nnoremap <silent> ZH :<C-u>call blank#up(v:count1)<CR>
nnoremap <silent> ZN :<C-u>call blank#down(v:count1)<CR>
