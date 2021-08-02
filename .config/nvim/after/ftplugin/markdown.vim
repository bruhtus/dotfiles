" preview markdown with `markdown-preview.nvim`

let maplocalleader = '\'

" reference: https://github.com/tpope/vim-markdown
let g:markdown_fenced_languages = ['bash=sh', 'sh', 'html', 'python']
let g:markdown_minlines = 69

" \\ to preview markdown
let g:mkdp_refresh_slow = 1
nnoremap <buffer> <silent> <localleader>\ :packadd markdown-preview.nvim<CR>:call mkdp#util#toggle_preview()<CR>
