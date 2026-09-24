" Ref:
" https://github.com/justinmk/config/commit/8e78250cd8f9be42d044f7b4448aa8b5fd42c60c
function! enable#fugitive_log#normal() abort
  if !exists('g:loaded_fugitive') | packadd vim-fugitive | endif

  let l:choice = confirm("Current file or All or Specific function git commit(s)?",
        \ "&NCancel\n&JCurrent\n&KAll\n&LFunction", 1)
  if l:choice == 1
    " do nothing
  elseif l:choice == 2
    -tab Git log --color=never --follow --date=short --format='%h %cd  %s (%an)%d' %
  elseif l:choice == 3
    -tab Git log --color=never --date=short --format='%h %cd  %s (%an)%d'
  elseif l:choice == 4
    exe '-tab Git log --color=never --date=short --pretty=format:"%h %cd  %s (%an)%d" -L :'
          \ . expand('<cword>') . ':' . expand('%:p')
  endif
endfunction

function! enable#fugitive_log#visual() abort
  if !exists('g:loaded_fugitive') | packadd vim-fugitive | endif

  exe '-tab Git log --color=never --date=short --pretty=format:"%h %cd  %s (%an)%d" -L '
        \ . line("'<") . ',' . line("'>") . ':' . expand('%:p')
  redraw!
endfunction
