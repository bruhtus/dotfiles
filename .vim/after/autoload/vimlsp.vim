function! vimlsp#init() abort
  " highlight link LspErrorHighlight SpellBad
  " highlight link LspHintHighlight SpellCap

  setlocal omnifunc=lsp#complete
  let g:lsp_diagnostics_signs_enabled = 1
  let g:lsp_diagnostics_signs_insert_mode_enabled = 1
  " let g:lsp_diagnostics_float_delay = 1
  let g:lsp_document_code_action_signs_enabled = 0
  let g:lsp_format_sync_timeout = 1000
  let g:lsp_preview_float = 1
  " Note: there's an error E685 when delete with range while there's a
  " diagnostics highlight.
  " Issue: https://github.com/prabirshrestha/vim-lsp/issues/888
  let g:lsp_diagnostics_highlights_enabled = 0
  " let g:lsp_diagnostics_highlights_delay = 1
  let g:lsp_hover_ui = 'float'

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
