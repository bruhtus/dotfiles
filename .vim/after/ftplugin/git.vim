if get(b:, 'fugitive_type') =~# '\v(temp|commit)' && !&modifiable
  setlocal bufhidden=wipe
  nnoremap <buffer> <nowait> <silent> q :<C-u>close<CR>
endif
