function! s:formatter() abort
  if !exists('g:loaded_neoformat')
    let g:neoformat_try_node_exe = 1
    " let g:neoformat_run_all_formatters = 1
    let g:neoformat_enabled_javascript = ['prettier']
    let g:neoformat_enabled_html = ['prettier']
    let g:neoformat_enabled_markdown = []
    packadd neoformat
  endif

  Neoformat
endfunction

" remap ex mode to format current buffer.
" we can still access ex mode using gQ.
nnoremap <silent> Q :<C-u>call <SID>formatter()<CR>
