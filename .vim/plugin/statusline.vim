" Ref: https://github.com/junegunn/dotfiles/blob/057ee47465e43aafbd20f4c8155487ef147e29ea/vimrc#L265-L275

function! Statusline() abort

  if mode() == 'n'
    let l:mode ='%#NormalModeColor# '
  elseif mode() == v:insertmode
    let l:mode ='%#InsertModeColor# '
  elseif mode() == 'v' || mode() == 'V' || mode() == "\<C-V>"
    let l:mode ='%#VisualModeColor# '
  elseif mode() == 'c' || mode() == 't'
    let l:mode ='%#CommandModeColor# '
  endif

  let l:filename = "%{winwidth(0) > 100 ? (expand('%:p:~') !=# '' ? expand('%:p:~') : '[Blank]') :
        \ winwidth(0) < 71 ? expand('%:t') :
        \ pathshorten((expand('%') !=# '' ? expand('%') : '[Blank]'))}"

  let l:readonly = "%{&readonly ? '[RO] ' : ''}"
  let l:mod = "%{&modified ? '  [+]' : !&modifiable ? '  [-]' : ''}"
  let l:ft = "%{winwidth(0) > 70 ? (len(&filetype) ? '['.&filetype.']' : '[no ft]') : ''}"
  let l:fugitive = "%{winwidth(0) > 70 ? (exists('g:loaded_fugitive') ? fugitive#statusline() : '') : ''}"
  let l:seperator = ' %= '
  let l:line = '%-12(%l/%L%)'
  return l:mode.'%* '.l:readonly.l:filename.l:mod.l:seperator.l:line.' %<'.l:ft.l:fugitive
endfunction

set statusline=%!Statusline()
