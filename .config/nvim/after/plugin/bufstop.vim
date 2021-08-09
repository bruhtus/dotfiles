" bufstop mapping
if exists('g:loaded_bufstop_mod')
  finish
endif

nnoremap <silent> <leader>n :call bufstop#preview()<CR>
