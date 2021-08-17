" Ref: https://github.com/junegunn/dotfiles/blob/057ee47465e43aafbd20f4c8155487ef147e29ea/vimrc#L265-L275

function! s:statusline_expr() abort

  " if mode() == 'n'
  "   let w:mode ='%#NormalModeColor# '
  " elseif mode() == v:insertmode
  "   let w:mode ='%#InsertModeColor# '
  " elseif mode() == 'v' || mode() == 'V' || mode() == "\<C-V>"
  "   let w:mode ='%#VisualModeColor# '
  " elseif mode() == 'c' || mode() == 't'
  "   let w:mode ='%#CommandModeColor# '
  " endif

  let l:filename = "%{expand('%:p:~') ==# '' ? '[Blank]':
        \ len(expand('%:p:~')) < winwidth(0)-17 ? expand('%:p:~') :
        \ len(expand('%:p:~')) > winwidth(0) ? expand('%:t') :
        \ pathshorten(expand('%:p:~'))}"

  let l:readonly = "%{&readonly ? '[RO] ' : ''}"
  let l:mod = "%{&modified ? '  [+]' : !&modifiable ? '  [-]' : ''}"
  let l:ft = "%{winwidth(0) > 70 ? (len(&filetype) ? '['.&filetype.']' : '[no ft]') : ''}"
  let l:fugitive = "%{winwidth(0) > 70 ? (exists('g:loaded_fugitive') ? fugitive#statusline() : '') : ''}"
  let l:separator = ' %= '
  let l:line = '%-12(%l/%L%)'
  " return w:mode.'%* '.l:readonly.l:filename.l:mod.l:seperator.l:line.' %<'.l:ft.l:fugitive
  return l:readonly.l:filename.l:mod.l:separator.l:line.' %<'.l:ft.l:fugitive
endfunction

" set statusline=%!Statusline()
let &statusline = s:statusline_expr()
