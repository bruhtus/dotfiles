setlocal nowrap

let g:quickr_preview_exit_on_enter = 1
let g:quickr_preview_line_hl       = 'search'
let g:quickr_preview_options       = 'number norelativenumber nofoldenable scrolloff=999 colorcolumn='

nmap <buffer> <nowait> d <C-d>
nmap <buffer> <nowait> u <C-u>
nmap <buffer> <silent> <nowait> m <CR>zz<C-w>p
nmap <buffer> <nowait> <Space> <Plug>(quickr_preview)
" for whatever reason the preview window won't close if qf window already
" closed in vanilla vim
nnoremap <buffer> <silent> i :cclose <Bar> lclose <Bar> pclose<CR>
