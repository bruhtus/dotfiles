" To access the man page in vim, use `<leader>K`.
" Example to access specific man page section: `:Man 3 sleep`.
let g:ft_man_open_mode = 'tab'
let g:ft_man_no_sect_fallback = 1
runtime! ftplugin/man.vim
