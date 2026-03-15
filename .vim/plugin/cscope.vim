" References:
" - :help cscope-options
" - https://cscope.sourceforge.net/cscope_vim_tutorial.html
" - https://github.com/ronakg/quickr-cscope.vim/blob/master/plugin/quickr-cscope.vim#L208
" - https://github.com/brookhong/cscope.vim/blob/master/plugin/cscope.vim

if !has('cscope') || (has('cscope') && !executable('cscope'))
  finish
endif

if has('quickfix')
  set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
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

function! s:cscope_reset() abort
  let l:msg = system('cscope -Rbq')

  if l:msg != ''
    echom l:msg
    return
  endif

  cs reset
endfunction

nnoremap <silent> <C-\><C-r> :<C-u>call <SID>cscope_reset()<CR>
