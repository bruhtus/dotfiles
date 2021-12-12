" only load vim-lsp in vanilla vim

if !has('nvim')
  let g:lsp_auto_enable = 0
  let g:lsp_settings_enable_suggestions = 0

  nnoremap <leader>w :call lsp#enable() <Bar> LspStatus<CR>

  augroup lsp_enabled
    autocmd!
    autocmd User lsp_buffer_enabled call vimlsp#init()
  augroup END
endif
