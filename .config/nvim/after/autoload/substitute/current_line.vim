" source: https://vi.stackexchange.com/a/8662/34851
"
" to match the Nth occurence, you can use `\zs` and `\{N}`
" example: `:s/\v(.{-}\zs<pattern>.){2}//`, it's gonna remove 2nd occurence of
" <pattern>
" More info: `:h \zs`

" split current line based on comma inside parentheses
" Ref: https://stackoverflow.com/a/33337692
" :h sub-replace-special
function! substitute#current_line#split_by_comma_parentheses()
  try
    norm m`
    s/(.\{-})/\=substitute(submatch(0), ',', ',\r', 'g')
    norm ``
    norm m`
    s/(/(\r/g
    norm =ip
    norm ``
  catch
    echo "There's no comma inside parentheses or no parentheses"
  endtry
endfunction
