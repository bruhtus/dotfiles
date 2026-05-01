" References:
" - :help cscope-options
" - https://cscope.sourceforge.net/cscope_vim_tutorial.html
" - https://github.com/ronakg/quickr-cscope.vim/blob/master/plugin/quickr-cscope.vim#L208
" - https://github.com/brookhong/cscope.vim/blob/master/plugin/cscope.vim

if !has('cscope') || (has('cscope') && !executable('cscope'))
  finish
endif

if has('quickfix')
  set cscopequickfix=s-,c-,d-,t-,e-
endif

set cscopetag cscoperelative cscopetagorder=0 cscopepathcomp=3

if filereadable('cscope.out')
  cs add cscope.out
elseif exists('$CSCOPE_DB')
  cs add $CSCOPE_DB
endif

" So that we get useful message when the database
" failed when we add __more__ databases afterwards.
set cscopeverbose

nnoremap <silent> <C-\>s :<C-u>exe 'cs find s ' . expand('<cword>')<CR>
nnoremap <silent> <C-\>c :<C-u>exe 'cs find c ' . expand('<cword>')<CR>
nnoremap <silent> <C-\>d :<C-u>exe 'cs find d ' . expand('<cword>')<CR>
nnoremap <silent> <C-\>a :<C-u>exe 'cs find a ' . expand('<cword>')<CR>

" Find files that #include the WORD under cursor.
nnoremap <silent> <C-\>i :<C-u>exe 'cs find i ' . substitute(
      \   expand('<cWORD>'),
      \   '[><"]',
      \   '',
      \   'g',
      \ )<CR>

function! s:custom_cscope() abort
  call inputsave()
  let l:input = input('Cscope find: ')
  call inputrestore()

  redraw!

  if empty(l:input)
    echo 'Cscope: nothing to query'
    return
  endif

  let l:choice = confirm('Select query type',
        \ "&No\n&text\n&egrep\n&file", 1)

  if l:choice == 1
    return
  elseif l:choice == 2
    let l:qtype = 't'
  elseif l:choice == 3
    let l:qtype = 'e'
  elseif l:choice == 4
    let l:qtype = 'f'
  endif

  if !exists('l:qtype')
    echo 'Cscope: query type does not exist'
    return
  endif

  redraw!

  try
    exe 'cs find ' . l:qtype . ' ' . l:input
  catch  /^Vim\%((\a\+)\)\=:E259/
    echo substitute(v:exception, 'Vim(\w\+):E259: ', '', '')
  catch
    echoerr v:exception
  endtry
endfunction

nnoremap <silent> <C-\>f :<C-u>call <SID>custom_cscope()<CR>

function! s:cscope_reset() abort
  let l:cmd = 'cscope -Rbq'

  let l:choice = confirm('Use default update command or custom?',
        \ "&Default\n&Custom", 1)

  if l:choice == 1
    " Do nothing.
  elseif l:choice == 2
    redraw!
    call inputsave()
    let l:cmd = input('Command: ')
    call inputrestore()
  endif

  redraw!

  echo 'Updating...'

  let l:msg = system(l:cmd)

  if v:shell_error != 0
    echom l:msg
    return
  endif

  redraw!

  cs reset
endfunction

nnoremap <silent> <C-\><C-r> :<C-u>call <SID>cscope_reset()<CR>
