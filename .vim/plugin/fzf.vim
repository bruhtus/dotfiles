" fzf plugin config and mappings

let $FZF_DEFAULT_COMMAND = "rg --hidden --files"

" open fzf to search all files in home directory
nnoremap <leader>f :Files ~<CR>

" open fzf to search all files in loaded buffers
nnoremap <leader>i :Buffers<CR>

" open fzf to search all lines in current buffer
nnoremap <leader>u :BLines<CR>

" open fzf to search all content in current working directory
nnoremap <leader>o :Rg<CR>
