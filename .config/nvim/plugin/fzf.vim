" fzf plugin mappings

" open fzf to search all files in home directory
nnoremap <leader>f :call enable#fzf() \| Files ~<CR>

" open fzf to search all files in current working directory
nnoremap <leader>i :call enable#fzf() \| Files<CR>

" open fzf to search all lines in current buffer
nnoremap <leader>u :call enable#fzf() \| CustomBLines<CR>

" open fzf to search all content in current working directory
nnoremap <leader>o :call enable#fzf() \| Rg<CR>

" change current working directory with fzf (still WIP)
" nnoremap <silent> <leader>y :call enable#fzf() \| call fzf#run(fzf#wrap({'source': 'fd -aHI -E .git -t d', 'sink': 'lcd'}))<CR>
