finish
" make incsearch appear in the middle
if &incsearch
  augroup incsearch_center
    autocmd!

    " Ref: https://vi.stackexchange.com/a/8684
    " cannot put trailing white space with mapping (:h E31)
    autocmd CmdlineEnter /,\?
          \ if empty(v:operator)     |
          \   setlocal scrolloff=999 |
          \   cnoremap <CR> <CR>zz|
          \ endif

    " cannot put trailing white space with mapping (:h E31)
    autocmd CmdlineLeave /,\?
          \ if empty(v:operator)    |
          \   setlocal scrolloff=-1 |
          \   cunmap <CR>|
          \ endif

    " autocmd CmdlineEnter /,\? setlocal scrolloff=999
    " autocmd CmdlineLeave /,\? setlocal scrolloff=-1
    " autocmd CmdlineEnter /,\? setlocal scrolloff=999 | cnoremap <CR> <CR>zz | redraw
  augroup END
endif
