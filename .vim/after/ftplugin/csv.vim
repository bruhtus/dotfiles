setlocal nowrap colorcolumn=
let b:no_trim_whitespace = 1

" Ref: https://github.com/chrisbra/csv.vim/blob/master/autoload/csv.vim
" Ref: https://vim.fandom.com/wiki/Working_with_CSV_files
" Note: because syntax file sourced first, re-use that if possible.
let s:hiGroup = 'Visual'
let b:delimiter = get(g:, 'csv_delim', ',')
let s:del = get(b:, 'del', '\%(' . b:delimiter . '\|$\)')
let s:del_noend = get(b:, 'del_noend', '\%(' . b:delimiter . '\)')
let b:col = get(b:, 'col',
      \ '\%(\%(\%(' . (b:delimiter !~ '\s' ? '\s*' : '') .
      \ '"\%(' . (exists("g:csv_nl") ? '\_' : '' ) .
      \ '[^"]\|""\)*"\s*\)' . s:del . '\)\|\%(' .
      \  '[^' .  b:delimiter . ']*' . s:del . '\)\)')
let b:col_end = get(b:, 'col_end',
      \ '\%(\%(\%(' . (b:delimiter !~ '\s' ? '\s*' : '') .
      \ '"\%(' . (exists("g:csv_nl") ? '\_' : '' ) .
      \ '[^"]\|""\)*"\)' . s:del_noend . '\)\|\%(' .
      \  '[^' .  b:delimiter . ']*' . s:del_noend . '\)\)')

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
  let l:fields = (
        \   split(
        \     l:line[0:l:end],
        \     b:col . '\zs'
        \   )
        \ )
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

function! s:csv_highlight(on) abort
  let l:colnr = s:csv_column()

  if l:colnr == 1
    let l:pat = '^'. s:csv_get_column_pattern(l:colnr, 0)
  else
    let l:pat = '^'. s:csv_get_column_pattern(l:colnr-1, 1) . b:col
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
    if !a:on
      return
    endif
    let s:matchid = matchadd(s:hiGroup, l:pat, 0)
  elseif a:on
    exe ":2match " . s:hiGroup . ' /' . l:pat . '/'
  endif
endfunction

function! s:csv_get_header() abort
  let l:colnr = s:csv_column()
  let l:header_line = getline(
        \   get(b:, 'csv_header_line', 1)
        \ )

  let l:header = split(l:header_line, b:col . '\zs')
  let l:trim_header_whitespace = substitute(
        \   l:header[l:colnr-1],
        \   '^\s\+',
        \   '',
        \   '',
        \ )

  return substitute(
        \   l:trim_header_whitespace,
        \   b:delimiter,
        \   '',
        \   '',
        \ )
endfunction

nnoremap <silent> <buffer> gd :echo <SID>csv_get_header()<CR>
nnoremap <silent> <buffer> gj :call <SID>csv_highlight(1)<CR>
nnoremap <silent> <buffer> gk :call <SID>csv_highlight(0)<CR>
