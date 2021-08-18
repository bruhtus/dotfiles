" inspired by $VIMRUNTIME/ftplugin/vim.vim
" use `]]` and `[[` in operator pending mode too
onoremap <buffer> <silent> ]] :<C-u>call search('^\s*\(fu\%[nction]\\|def\)\>', 'W')<CR>
onoremap <buffer> <silent> [[ :<C-u>call search('^\s*\(fu\%[nction]\\|def\)\>', 'bW')<CR>

" there's some inconsistent indentation with vim-sleuth in vim filetype
let b:sleuth_automatic = 0
