" minimalist vim-rooter alternative

" inspired by tpope's vim-sensible plugin
" doesn't support autochdir option
if &autochdir
  set noautochdir
endif

function! s:root_buffer()
  if !exists('b:root_enabled')
    " change directory to file directory automatically
    " almost the same as `set autochdir` but more flexible
    silent! lcd %:p:h
  else
    unlet b:root_enabled
    silent! lcd %:p:h
    call root#toggle()
  endif
endfunction

augroup RootBuffer
  autocmd!
  autocmd BufEnter * call s:root_buffer()
augroup END

nnoremap <silent> - :call root#toggle()<CR>

" vim:set et sw=2
