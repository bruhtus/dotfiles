" Ref: https://github.com/chrisbra/csv.vim/blob/master/syntax/csv.vim
if exists('b:current_syntax')
  finish
endif

let b:delimiter = get(g:, 'csv_delim', ',')
let b:del = '\%(' . b:delimiter . '\|$\)'
let b:del_noend = '\%(' . b:delimiter . '\)'
let b:col =
      \ '\%(\%(\%(' . (b:delimiter !~ '\s' ? '\s*' : '') .
      \ '"\%(' . (exists("g:csv_nl") ? '\_' : '' ) .
      \ '[^"]\|""\)*"\s*\)' . b:del . '\)\|\%(' .
      \  '[^' .  b:delimiter . ']*' . b:del . '\)\)'
let b:col_end =
      \ '\%(\%(\%(' . (b:delimiter !~ '\s' ? '\s*' : '') .
      \ '"\%(' . (exists("g:csv_nl") ? '\_' : '' ) .
      \ '[^"]\|""\)*"\)' . b:del_noend . '\)\|\%(' .
      \  '[^' .  b:delimiter . ']*' . b:del_noend . '\)\)'

exe 'syn match CSVColumnEven nextgroup=CSVColumnOdd /'
      \ . b:col . '/ contains=CSVDelimiter'
exe 'syn match CSVColumnOdd nextgroup=CSVColumnEven /'
      \ . b:col . '/ contains=CSVDelimiter'
exe 'syn match CSVColumnHeaderEven nextgroup=CSVColumnHeaderOdd /\%<'. (get(b:, 'csv_headerline', 1)+1).'l'
      \. b:col . '/ contains=CSVDelimiter'
exe 'syn match CSVColumnHeaderOdd nextgroup=CSVColumnHeaderEven /\%<'. (get(b:, 'csv_headerline', 1)+1).'l'
      \. b:col . '/ contains=CSVDelimiter'
exe "syn match CSVDelimiter /" . b:col_end . '/ms=e,me=e contained'

" Note: this highlight based on seoul256mod.
hi def link CSVDelimiter Delimiter
hi def link CSVColumnHeaderOdd Normal
hi def link CSVColumnHeaderEven SpellLocal
hi def link CSVColumnOdd Normal
hi def link CSVColumnEven SpellLocal

let b:current_syntax = "csv"
