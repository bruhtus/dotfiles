" Ref: https://stackoverflow.com/a/26544046

" xnoremap <silent> Q :<C-u>call ilist_qf#load(1, 0)<CR>

" search current visual selection and display that in location list
" for now, use register v to save the selected word
" is it possible to do this without using register?
xnoremap <silent> Q "vy:let @v=substitute(@v, '\n$', '', 'g')<CR>:lvimgrep /<C-r>v/j %<CR>:let @v=''<CR>
