" fzf plugin config and mappings

let $FZF_DEFAULT_COMMAND = "rg --hidden --files --no-ignore-vcs"

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-s': 'vsplit' }

let g:fzf_preview_window = ['up:50%']

" open fzf to search all files in home directory
nnoremap <leader>f :Files ~<CR>

" open fzf to search all files in current working directory
nnoremap <leader>i :Files<CR>

" open fzf to search all lines in current buffer
nnoremap <leader>u :BLines<CR>

" open fzf to search all content in current working directory
nnoremap <leader>o :Rg<CR>

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:50%'), <bang>0)
