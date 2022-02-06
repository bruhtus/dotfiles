function! vimlsp#init() abort
  setlocal omnifunc=lsp#complete
  let g:lsp_diagnostics_signs_enabled = 0
  let g:lsp_diagnostics_signs_insert_mode_enabled = 0
  let g:lsp_document_code_action_signs_enabled = 0
  let g:lsp_format_sync_timeout = 1000
  let g:lsp_preview_float = 0
  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_diagnostics_echo_delay = 1
  let g:lsp_diagnostics_highlight_delay = 1
  let g:lsp_hover_ui = 'preview'

  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <Plug>(lsp-definition)
  " nmap <buffer> gs <plug>(lsp-document-symbol-search)
  " nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  " nmap <buffer> <leader>q <plug>(lsp-references)
  " nmap <buffer> <leader>z <plug>(lsp-implementation)
  " nmap <buffer> <leader>x <plug>(lsp-type-definition)
  " nmap <buffer> <leader>e <plug>(lsp-rename)
  nmap <buffer> K <Plug>(lsp-hover)
  nmap <silent> <buffer> gs <Plug>(lsp-document-diagnostics)
  " nnoremap <expr> <buffer> <c-f> lsp#scroll(+4)
  " nnoremap <expr> <buffer> <c-d> lsp#scroll(-4)
endfunction
