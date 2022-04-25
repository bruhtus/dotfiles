function! enable#gv#normal()
  if !exists(':GV')
    if !exists('g:loaded_fugitive') | packadd vim-fugitive | endif
    packadd gv.vim
  endif

  let l:choice = confirm("Current file git commit(s) or All git commit(s)?",
        \	"&JCurrent\n&KAll\n&NCancel", 3)
  if l:choice == 1
    try
      GV!
    catch /^Vim\%((\a\+)\)\=:E492/
      echo 'Gv plugin not installed'
    endtry
  elseif l:choice == 2
    try
      GV
    catch /^Vim\%((\a\+)\)\=:E492/
      echo 'Gv plugin not installed'
    endtry
  elseif l:choice == 3
    " do nothing
  endif
endfunction

function! enable#gv#visual()
  if !exists(':GV')
    if !exists('g:loaded_fugitive') | packadd vim-fugitive | endif
    packadd gv.vim
  endif

  let l:choice = confirm("Current file git commit(s) or All git commit(s)?",
        \	"&JCurrent\n&KAll\n&NCancel", 3)
  if l:choice == 1
    try
      '<,'>GV
    catch /^Vim\%((\a\+)\)\=:E492/
      echo 'Gv plugin not installed'
    endtry
  elseif l:choice == 2
    try
      '<,'>GV
    catch /^Vim\%((\a\+)\)\=:E492/
      echo 'Gv plugin not installed'
    endtry
  elseif l:choice == 3
    " do nothing
  endif
endfunction
