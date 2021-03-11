" preview markdown with `glow` (on AUR)

let maplocalleader = '\'

" \\ to preview markdown
autocmd BufRead,BufNewFile *.md nnoremap <buffer> <localleader>\ :!glow -p %<CR>
