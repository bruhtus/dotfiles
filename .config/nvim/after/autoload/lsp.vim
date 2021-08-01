function! lsp#toggle()
  if !exists(':LspInstall')
    packadd nvim-lspconfig | packadd nvim-lspinstall
    lua require('lsp')
    set omnifunc=v:lua.vim.lsp.omnifunc
  endif

  if exists(':LspStart')
    if exists('g:lsp_running')
      unlet g:lsp_running
      LspStop
      set pumheight=0
      echo 'Stopping LSP'
    else
      let g:lsp_running = 1
      LspStart
      set pumheight=5
      echo 'Starting LSP'
    endif

    augroup ForgotTurnOffLSP
      autocmd!
      autocmd VimLeavePre * if exists('g:lsp_running') | LspStop | endif
    augroup END
  endif
endfunction
