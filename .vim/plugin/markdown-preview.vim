" markdown-preview plugin config and mapping

let maplocalleader = '\'

" markdown-preview config
let g:mkdp_refresh_slow = 1
let g:mkdp_browser      = 'qutebrowser'

" space h to preview markdown
nnoremap <buffer> <localleader>\ :MarkdownPreview<CR>
