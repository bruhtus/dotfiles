function! enable#goyo()
  if !exists(':Goyo') | packadd goyo.vim | endif
  try
    Goyo
  catch /^Vim\%((\a\+)\)\=:E492/
    echo 'Goyo plugin not installed'
  endtry
endfunction

function! enable#rainbow()
  if !exists(':RainbowToggle')
    try
      let g:rainbow_active = 0
      packadd rainbow
      RainbowToggle
    catch /^Vim\%((\a\+)\)\=:E492/
      echo 'Rainbow plugin not installed'
    endtry
  else
    RainbowToggle
  endif
endfunction

function! enable#fugitive()
  try
    if &filetype !=# 'fugitive' && empty(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") ==# "fugitive"'))
      if !exists('g:loaded_fugitive') | packadd vim-fugitive | endif
      Git
    elseif &filetype !=# 'fugitive' && !empty(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") ==# "fugitive"'))
      " it seems fugitive status is always the last window which is convenient
      exe "$windo norm gq"
    else
      norm gq
    endif
  catch /^Vim\%((\a\+)\)\=:fugitive/
    echo 'Not git repo'
  catch  /^Vim\%((\a\+)\)\=:E492/
    echo 'Fugitive plugin not installed'
  endtry
endfunction

function! enable#filebeagle()
  if !exists(':FileBeagleBufferDir')
    try
      let g:filebeagle_suppress_keymaps = 1
      packadd vim-filebeagle
      FileBeagleBufferDir
    catch /^Vim\%((\a\+)\)\=:E492/
      echo 'Filebeagle plugin not installed'
    endtry
  else
    FileBeagleBufferDir
  endif
endfunction

function! enable#fzf(cmd)
  if !exists('g:loaded_fzf_vim')
    try
      call enable#fzf#init()
      exe a:cmd
    catch /^Vim\%((\a\+)\)\=:E117/
      echo 'Fzf plugin not installed or enable#fzf#init() function not found'
    endtry
  else
    exe a:cmd
  endif
endfunction
