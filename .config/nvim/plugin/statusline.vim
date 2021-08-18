" statusline config

" why would you want to load this if you don't want to use statusline?
if !&laststatus
  if !&showmode | set showmode | endif
  finish
endif

" do not change statusline of quickfix and bufstop window
augroup StatuslineStartup
  autocmd!
  autocmd WinEnter,BufWinEnter *
        \ if &buftype ==# 'quickfix'      |
        \ elseif &buftype ==# 'nofile'    |
        \ else                            |
        \   call StatuslineLoad('active') |
        \ endif

  autocmd WinLeave *
        \ if &buftype ==# 'quickfix'        |
        \ elseif &buftype ==# 'nofile'      |
        \ else                              |
        \   call StatuslineLoad('inactive') |
        \ endif
augroup END

function! StatuslineLoad(mode)
  if a:mode ==# 'active'
    setlocal statusline=%!StatuslineComponent()
  else
    setlocal statusline=%!StatuslineNcComponent()
  endif
endfunction

" Ref: https://github.com/junegunn/dotfiles/blob/057ee47465e43aafbd20f4c8155487ef147e29ea/vimrc#L265-L275
function! StatuslineComponent() abort

  if mode() ==# 'n'
    let w:mode ='%#NormalModeColor# '
  elseif mode() ==# v:insertmode
    let w:mode ='%#InsertModeColor# '
  elseif mode() ==# 'v' || mode() ==# 'V' || mode() ==# "\<C-V>"
    let w:mode ='%#VisualModeColor# '
  elseif mode() ==# 'c' || mode() ==# 't'
    let w:mode ='%#CommandModeColor# '
  endif

  let l:filename = " %{expand('%:p:~') ==# '' ? '[Blank]' :
        \ winwidth(0) > 160 ? expand('%:p:~') :
        \ winwidth(0) < 71 ? expand('%:t') :
        \ pathshorten(expand('%'))}"
  let l:readonly = "%r"
  let l:mod = "%{&modified ? '  [+]' : !&modifiable ? '  [-]' : ''}"
  let l:ft = "%{winwidth(0) > 70 ? (len(&filetype) ? &filetype : 'no ft') : ''}"
  let g:gitbranchcmd = "git branch --show-current 2>/dev/null | tr -d '\n'"
  let l:git = "%{exists('*FugitiveHead') ? (winwidth(0) > 70 ? fugitive#head() : '') :
        \ (winwidth(0) > 70 ? system(g:gitbranchcmd) : '')}"
  let l:sep = '%='
  let l:line = '  %3l/%L'
  return w:mode.'%* '.l:git.l:sep.l:readonly.l:filename.l:mod.l:sep.l:ft.l:line
endfunction

function! StatuslineNcComponent() abort
  let l:filename = " %{expand('%:p:~') ==# '' ? '[Blank]' :
        \ winwidth(0) > 160 ? expand('%:p:~') :
        \ winwidth(0) < 71 ? expand('%:t') :
        \ pathshorten(expand('%'))}"
  let l:readonly = "%r"
  let l:mod = "%{&modified ? '  [+]' : !&modifiable ? '  [-]' : ''}"
  let l:sep = '%='
  return l:sep.l:readonly.l:filename.l:mod.l:sep
endfunction
