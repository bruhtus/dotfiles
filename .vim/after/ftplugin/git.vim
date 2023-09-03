if get(b:, 'fugitive_type') =~# '\v(temp|commit)' && !&modifiable
  setlocal bufhidden=wipe
endif
