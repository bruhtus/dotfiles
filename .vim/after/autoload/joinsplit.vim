" source: https://vi.stackexchange.com/a/8662/34851
"
" to match the Nth occurence, you can use `\zs` and `\{N}`
" example: `:s/\v(.{-}\zs<pattern>.){2}//`, it's gonna remove 2nd occurence of
" <pattern>
" More info: `:h \zs`

" split current line based on comma inside parentheses
" Ref: https://stackoverflow.com/a/33337692
" :h sub-replace-special
" function! joinsplit#split_by_comma()
"   try
"     norm m`
"     s/(.\{-})/\=substitute(submatch(0), ',', ',\r', 'g')
"     norm ``
"     norm m`
"     s/(/(\r/g
"     norm =ip
"     norm ``
"   catch
"     echo "There's no comma inside parentheses or no parentheses"
"   endtry
" endfunction

function! joinsplit#exec_join() abort
  set operatorfunc=s:join_lines
  return 'g@'
endfunction

" Ref:
" https://github.com/jeetsukumaran/vim-linearly/blob/master/plugin/linearly.vim
function! s:join_lines(submode) abort
  norm! m`
  '[,']join
  norm! g``
endfunction

" Ref:
" https://github.com/Konfekt/vim-sentence-chopper/blob/master/autoload/sentences.vim
function! joinsplit#split_line_on_pattern(open, close) abort
  norm! m`
  let gdefault = &gdefault
  set gdefault&
  call inputsave()
  let pattern = input('pattern on which to split: ')
  call inputrestore()
  let subs =
        \ '\C\v(%(%([\])''"[:space:]-][[:upper:][:lower:]]{2,}|[[:digit:]]{3,}|[ivx]{5,}|[IVX]{5,}|[\])''"])[.]|['
        \ . pattern . ']))%(\s+|([\])''"]))\ze\S' . '/' . '\1\2\r'
  if a:open == "'[" && a:close == "']"
    exe 'silent keeppatterns ' . a:open . ',' . a:close . 'substitute/' . subs . '/geI'
  else
    " Known Issue: only able to substitute the first occurrence
    exe 'silent keeppatterns ' . 'substitute/\%V' . subs . '/geI'
  endif
  let &gdefault = gdefault
  let equalprg = &l:equalprg
  let equalprg = ''
  exe 'silent keepjumps normal! ' . a:open . '=' . a:close
  let &l:equalprg = equalprg
  norm! g``
endfunction
