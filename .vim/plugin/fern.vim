" fern plugin config and mappings

" disable fern default mappings
let g:fern#disable_default_mappings = 1

" remap - to open fern on the side
nnoremap <silent> - :Fern . -drawer -toggle<CR>

" fern mapping
function! s:init_fern() abort
	nmap <buffer> X <Plug>(fern-action-open:split)
	nmap <buffer> S <Plug>(fern-action-open:vsplit)
	nmap <buffer> h <Plug>(fern-action-collapse)
	nmap <buffer> l <Plug>(fern-action-open-or-expand)
	nmap <buffer> c <Plug>(fern-action-copy)
	nmap <buffer> Y <Plug>(fern-action-yank:path)
	nmap <buffer> ! <Plug>(fern-action-hidden:toggle)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
