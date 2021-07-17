" preview markdown with `markdown-preview.nvim`

let maplocalleader = '\'

" \\ to preview markdown
let g:mkdp_refresh_slow = 1
nnoremap <buffer> <silent> <localleader>\ :packadd markdown-preview.nvim<CR>:call mkdp#util#toggle_preview()<CR>
