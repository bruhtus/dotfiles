" if there's no count, use like the default J
" if there's count, use the operatorfunc
" nnoremap <expr> <silent> J
"       \ v:count > 0 ? ':<C-u>set operatorfunc=joinsplit#join_lines<CR>g@' . v:count :
"       \ 'm`J``'
nnoremap <silent> J :<C-u>set operatorfunc=joinsplit#join_lines<CR>g@

" the default gs normal mode command put vim in sleep state (can't
" interact with vim at certain time), the count decided how long the sleep
" state last. more info: :h gs
nnoremap <silent> gs :<C-u>call joinsplit#split_line_on_pattern("'[", "']")<CR>
xnoremap <silent> gs :<C-u>call joinsplit#split_line_on_pattern("'<", "'>")<CR>
