" Ref: https://vi.stackexchange.com/a/14990
if exists('*getcompletion()') && !empty(getcompletion('csv', 'filetype'))
  au BufNewFile,BufRead *.csv set filetype=csv
endif
