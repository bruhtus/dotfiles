let g:neoformat_try_node_exe = 1

" Note: for some reason, i need to make this into a function so that this
" autocmd doesn't interfere with trim whitespace autocmd.
function! s:neoformat_on_save() abort
  if !exists('g:no_formatter') && exists(':Neoformat')
    Neoformat
  endif
endfunction

augroup neoformat_on_save
  autocmd!
  autocmd BufWritePre * call s:neoformat_on_save()
augroup END
