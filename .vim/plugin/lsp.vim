" only load vim-lsp in vanilla vim

" let g:lsp_auto_enable = 0
let g:lsp_settings_enable_suggestions = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 1
let g:lsp_signature_help_enabled = 0
" let g:lsp_diagnostics_float_cursor = 1

" nnoremap <leader>w :call lsp#enable() <Bar> LspStatus<CR>

augroup lsp_enabled
  autocmd!
  autocmd User lsp_buffer_enabled call vimlsp#init()
  autocmd BufEnter LspHoverPreview
        \ nnoremap <silent> <nowait> <buffer>  q :<C-u>bw<CR>
augroup END
