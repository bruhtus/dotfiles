setlocal nowrap colorcolumn=

" Ref: https://vim.fandom.com/wiki/Working_with_CSV_files
" TODO: figure out how to highlight word under cursor.
function! s:csv_highlight(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute '2match Error /^\([^,]*,\)\{'.n.'}\zs[^,]*\,/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    2match Keyword /^[^,]*/
    normal! 0
  else
    2match
  endif
endfunction

command! -nargs=1 Csv call s:csv_highlight(<args>)
