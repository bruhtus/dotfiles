function! vimlsp#init() abort
  setlocal omnifunc=lsp#complete
  let g:lsp_diagnostics_signs_enabled = 0
endfunction
