" Ref: https://github.com/chrisbra/csv.vim/blob/master/syntax/csv.vim
if exists('b:current_syntax')
  finish
endif

" TODO: refactor this so that we can use this in csv ftplugin.
let s:del_def = ','
let s:del = '\%(' . s:del_def . '\|$\)'
let s:del_noend = '\%(' . s:del_def . '\)'
let s:col =
      \ '\%(\%(\%(' . (s:del_def !~ '\s' ? '\s*' : '') .
      \ '"\%(' . (exists("g:csv_nl") ? '\_' : '' ) .
      \ '[^"]\|""\)*"\s*\)' . s:del . '\)\|\%(' .
      \  '[^' .  s:del_def . ']*' . s:del . '\)\)'
let s:col_end='\%(\%(\%(' . (s:del_def !~ '\s' ? '\s*' : '') .
      \ '"\%(' . (exists("g:csv_nl") ? '\_' : '' ) .
      \ '[^"]\|""\)*"\)' . s:del_noend . '\)\|\%(' .
      \  '[^' .  s:del_def . ']*' . s:del_noend . '\)\)'
let s:del = get(b:, 'delimiter', s:del_def)

exe 'syn match CSVColumnEven nextgroup=CSVColumnOdd /'
      \ . s:col . '/ contains=CSVDelimiter'
exe 'syn match CSVColumnOdd nextgroup=CSVColumnEven /'
      \ . s:col . '/ contains=CSVDelimiter'
exe 'syn match CSVColumnHeaderEven nextgroup=CSVColumnHeaderOdd /\%<'. (get(b:, 'csv_headerline', 1)+1).'l'
      \. s:col . '/ contains=CSVDelimiter'
exe 'syn match CSVColumnHeaderOdd nextgroup=CSVColumnHeaderEven /\%<'. (get(b:, 'csv_headerline', 1)+1).'l'
      \. s:col . '/ contains=CSVDelimiter'
exe "syn match CSVDelimiter /" . s:col_end . '/ms=e,me=e contained'

" Note: this highlight based on seoul256mod.
hi def link CSVDelimiter Delimiter
hi def CSVColumnHeaderOdd ctermbg=NONE ctermfg=153 guibg=NONE guifg='#afd7ff'
hi def link CSVColumnHeaderEven ModeMsg
hi def link CSVColumnOdd String
hi def link CSVColumnEven Statement

let b:current_syntax = "csv"
