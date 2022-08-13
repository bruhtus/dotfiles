" Note: execute the return value.
function! s:error_handling(plugin_name, ...) abort
  let l:msg = get(a:000, 0, '')
  if !empty(l:msg)
    let l:error = 'echom "enable.vim:' . a:plugin_name . ':"' . string(l:msg)
  else
    let l:error = 'echom "enable.vim:' . a:plugin_name . ':"' . string(v:exception)
  endif
  return 'echohl Error | ' . l:error . ' | echohl None'
endfunction

function! enable#goyo()
  if !exists(':Goyo') | packadd goyo.vim | endif
  try
    Goyo
  catch /^Vim\%((\a\+)\)\=:E492/
    exe s:error_handling('goyo', 'Goyo is not installed')
  catch
    exe s:error_handling('goyo')
  endtry
endfunction

function! enable#rainbow()
  if !exists(':RainbowToggle')
    let g:rainbow_active = 0 | packadd rainbow
  endif
  try
    RainbowToggle
  catch /^Vim\%((\a\+)\)\=:E492/
    exe s:error_handling('rainbow', 'Rainbow is not installed')
  catch
    exe s:error_handling('rainbow')
  endtry
endfunction

function! enable#fugitive()
  try
    if &filetype !=# 'fugitive' && empty(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") ==# "fugitive"'))
      if !exists('g:loaded_fugitive') | packadd vim-fugitive | endif
      Git
    elseif &filetype !=# 'fugitive' && !empty(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") ==# "fugitive"'))
      " it seems fugitive status is always the last window which is convenient
      $windo norm gq
      wincmd p
    else
      norm gq
      wincmd p
    endif
  " catch /^Vim\%((\a\+)\)\=:fugitive/
  "   echo 'Not git repo'
  catch  /^Vim\%((\a\+)\)\=:E492/
    exe s:error_handling('fugitive', 'Fugitive is not installed')
  catch
    exe s:error_handling('fugitive')
  endtry
endfunction

function! enable#filebeagle()
  if !exists(':FileBeagleBufferDir')
    let g:filebeagle_suppress_keymaps = 1 | packadd vim-filebeagle
  endif
  try
    FileBeagleBufferDir
  catch /^Vim\%((\a\+)\)\=:E492/
    exe s:error_handling('filebeagle', 'Filebeagle is not installed')
  catch
    exe s:error_handling('filebeagle')
  endtry
endfunction

function! enable#undotree()
  try
    if !exists('g:loaded_undotree')
      packadd undotree
      let g:undotree_WindowLayout = 2
    endif
    UndotreeToggle
  catch  /^Vim\%((\a\+)\)\=:E492/
    exe s:error_handling('undotree', 'Undotree is not installed')
  catch
    exe s:error_handling('undotree')
  endtry
endfunction

function! enable#fzf(cmd)
  if !exists('g:loaded_fzf_vim')
    try
      call enable#fzf#init()
    catch /^Vim\%((\a\+)\)\=:E117/
      exe s:error_handling('fzf')
      return
    endtry
  endif
  try
    exe a:cmd
  catch
    exe s:error_handling('fzf')
  endtry
endfunction
