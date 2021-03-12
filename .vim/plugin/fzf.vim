" fzf plugin config and mappings

let $FZF_DEFAULT_COMMAND = "rg --hidden --files --no-ignore-vcs"

" open fzf to search all files in home directory
nnoremap <leader>f :Files ~<CR>

" open fzf to search all files in current working directory
nnoremap <leader>i :Files<CR>

" open fzf to search all lines in current buffer
nnoremap <leader>u :BLines<CR>

" open fzf to search all content in current working directory
nnoremap <leader>o :Rg<CR>

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
