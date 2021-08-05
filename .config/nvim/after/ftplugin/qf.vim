let g:quickr_preview_exit_on_enter = 1
let g:quickr_preview_line_hl       = 'search'
let g:quickr_preview_options       = 'number norelativenumber nofoldenable scrolloff=999 colorcolumn='

nmap <buffer> <nowait> d <C-d>
nmap <buffer> <nowait> u <C-u>
nmap <buffer> <silent> i :bw<CR>
nmap <buffer> <silent> <nowait> m <CR>zz
nmap <buffer> <nowait> <Space> <Plug>(quickr_preview)
