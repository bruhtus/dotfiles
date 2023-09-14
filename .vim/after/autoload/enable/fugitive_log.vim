" Ref:
" https://github.com/justinmk/config/commit/8e78250cd8f9be42d044f7b4448aa8b5fd42c60c
function! enable#fugitive_log#normal() abort
  if !exists('g:loaded_fugitive') | packadd vim-fugitive | endif

  let l:choice = confirm("Current file git commit(s) or All git commit(s)?",
        \ "&JCurrent\n&KAll\n&NCancel", 3)
  if l:choice == 1
    -tab Git log --color=never --date=short --format='%h %cd  %s (%an)%d' %
  elseif l:choice == 2
    -tab Git log --color=never --date=short --format='%h %cd  %s (%an)%d'
  elseif l:choice == 3
    " do nothing
  endif
endfunction

function! enable#fugitive_log#visual() abort
  if !exists('g:loaded_fugitive') | packadd vim-fugitive | endif

  exe '-tab Git log --color=never --date=short --format="%h %cd  %s (%an)%d" -L '
        \ . line("'<") . ',' . line("'>") . ':' . expand('%')
endfunction
