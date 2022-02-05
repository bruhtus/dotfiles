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
endfunction
