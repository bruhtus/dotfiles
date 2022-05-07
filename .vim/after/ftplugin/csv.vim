setlocal nowrap colorcolumn=

" Ref: https://github.com/chrisbra/csv.vim/blob/master/autoload/csv.vim
" Ref: https://vim.fandom.com/wiki/Working_with_CSV_files
let s:hiGroup = 'WildMenu'
let b:delimiter = get(g:, 'csv_delim', ',')
let s:del = '\%(' . b:delimiter . '\|$\)'
let b:col =
      \ '\%(\%(\%(' . (b:delimiter !~ '\s' ? '\s*' : '') .
      \ '"\%(' . (exists("g:csv_nl") ? '\_' : '' ) .
      \ '[^"]\|""\)*"\s*\)' . s:del . '\)\|\%(' .
      \  '[^' .  b:delimiter . ']*' . s:del . '\)\)'

" TODO: figure out how to make toogle to turn off highlight.
" TODO: figure out how to echo the csv header.
function! s:csv_highlight(off) abort
  let l:colnr = s:csv_column()

  if l:colnr == 1
    let l:pat = '^'. s:csv_get_column_pattern(l:colnr,0)
  else
    let l:pat = '^'. s:csv_get_column_pattern(l:colnr-1,1) . b:col
  endif

  if exists("*matchadd")
    if exists("s:matchid")
      " ignore errors, that come from already deleted matches
      sil! call matchdelete(s:matchid)
    endif
    " Additionally, filter all matches, that could have been used earlier
    let l:matchlist = getmatches()
    call filter(l:matchlist, 'v:val["group"] !~ s:hiGroup')
    call setmatches(l:matchlist)
    if a:off
      return
    endif
    let s:matchid = matchadd(s:hiGroup, l:pat, 0)
  elseif !a:off
    exe ":2match " . s:hiGroup . ' /' . l:pat . '/'
  endif
endfunction

function! s:csv_column() abort
  let l:cur = getpos('.')
  if line('.') > 1 && mode('') != 'n' && empty(getline('.')[0:col('.')-1])
    " in insert mode, get line from above, just in case the current
    " line is empty
    let l:line = getline(line('.')-1)
  else
    let l:line = getline('.')
  endif
  " move cursor to end of field
  "call search(b:col, 'ec', line('.'))
  call search(b:col, 'ec')
  let l:end = col('.')-1
  let l:fields = (split(l:line[0:l:end],b:col.'\zs'))
  let l:ret = len(l:fields)
  call setpos('.', l:cur)
  return l:ret
endfunction

function! s:csv_get_column_pattern(colnr, zs_flag) abort
  " Return Pattern for given column
  if a:colnr > 1
    let l:pat = b:col . '\{' . (a:colnr) . '\}'
  else
    let l:pat = b:col
  endif
  return l:pat . (a:zs_flag ? '\zs' : '')
endfunction

nnoremap <silent> <buffer> gd :call <SID>csv_highlight(0)<CR>
nnoremap <silent> <buffer> gD :call <SID>csv_highlight(1)<CR>
