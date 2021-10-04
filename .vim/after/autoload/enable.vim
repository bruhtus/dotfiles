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
    let g:rainbow_active = 0 | packadd rainbow
  endif
  try
    RainbowToggle
  catch /^Vim\%((\a\+)\)\=:E492/
    echo 'Rainbow plugin not installed'
  endtry
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
    let g:filebeagle_suppress_keymaps = 1 | packadd vim-filebeagle
  endif
  try
    FileBeagleBufferDir
  catch /^Vim\%((\a\+)\)\=:E492/
    echo 'Filebeagle plugin not installed'
  endtry
endfunction

function! enable#fzf(cmd)
  if !exists('g:loaded_fzf_vim')
    try
      call enable#fzf#init()
    catch /^Vim\%((\a\+)\)\=:E117/
      echo 'enable#fzf#init() function not found'
    endtry
  endif
  try
    exe a:cmd
  catch
    echo 'Fzf plugin not installed'
  endtry
endfunction
