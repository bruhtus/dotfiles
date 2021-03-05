" all stuff that need to compile

" space r to compile groff and space p to display the result
nnoremap <leader>r :w! \| !pdfroff -mspdf -t % > %:r.pdf<CR><CR>
nnoremap <leader>p :!zathura %:r.pdf&<CR><CR>

" space P to activate sent presentation
nnoremap <leader>P :w! \| !setsid -f sent %<CR><CR>
