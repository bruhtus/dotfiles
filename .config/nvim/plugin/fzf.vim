" fzf plugin mappings

" open fzf to search all files in home directory
nnoremap <leader>f :call enable#fzf() \| Files ~<CR>

" open fzf to search all files in current working directory
nnoremap <leader>i :call enable#fzf() \| Files<CR>

" open fzf to search all lines in current buffer
nnoremap <leader>u :call enable#fzf() \| BLines<CR>

" open fzf to search all content in current working directory
nnoremap <leader>o :call enable#fzf() \| Rg<CR>
