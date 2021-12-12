function! vimlsp#init() abort
  setlocal omnifunc=lsp#complete signcolumn=no
  let g:lsp_diagnostics_enabled = 0
  let g:lsp_diagnostics_highlights_enabled = 0
  let g:lsp_diagnostics_signs_enabled = 0
endfunction
