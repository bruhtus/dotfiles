" statusline config

" why would you want to load this if you don't want to use statusline?
if !&laststatus
  if !&showmode | set showmode! | endif
  finish
endif

" Ref: vim-lightline plugin
" make vim intro appear when vim start without filename
" let s:save_cpo = &cpo
" set cpo&vim

" do not change statusline of quickfix and bufstop window
augroup statusline_startup
  autocmd!
  autocmd WinEnter,BufWinEnter *
        \ if &buftype ==# 'quickfix'                 |
        \ elseif expand('%:t') ==# '--Bufstop--'     |
        \ else                                       |
        \   call s:gitbranch_detect(expand('%:p:h')) |
        \   call StatuslineLoad('active')            |
        \ endif

  autocmd BufNewFile,BufReadPost *
        \ call s:gitbranch_detect(expand('<amatch>:p:h'))

  autocmd WinLeave *
        \ if &buftype ==# 'quickfix'             |
        \ elseif expand('%:t') ==# '--Bufstop--' |
        \ else                                   |
        \   call StatuslineLoad('inactive')      |
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
  if g:colors_name ==# 'seoul256mod'
        \ && &laststatus == 2
        \ && !&showmode
    if mode() ==# 'n'
      let w:mode ='%#NormalModeColor# '
    " Note: v:insertmode only display the last mode that trigger `InsertEnter` and
    " `InsertChange`. maybe kind of similar to visualmode()? more info: `:h v:insertmode`
    elseif mode() ==# 'i'
          \ || mode() ==# 'R'
          \ || mode() ==# 'Rv'
      let w:mode ='%#InsertModeColor# '
    elseif mode() ==# 'v'
          \ || mode() ==# 'V'
          \ || mode() ==# "\<C-V>"
          \ || mode() ==# 's'
          \ || mode() ==# 'S'
          \ || mode() ==# "\<C-S>"
      let w:mode ='%#VisualModeColor# '
    elseif mode() ==# 'c' || mode() ==# 't'
      let w:mode ='%#CommandModeColor# '
    endif

  else
    if !&showmode | set showmode! | endif
    let w:mode=''
  endif

  let l:filename = " %{expand('%:p:~') ==# '' ? '[Blank]' :
        \ winwidth(0) > 160 ? expand('%:p:~') :
        \ winwidth(0) < 71 ? expand('%:t') :
        \ pathshorten(expand('%'))}"
  let l:readonly = '%r'
  let l:mod = "%{&modified ? '  [+]' : !&modifiable ? '  [-]' : ''}"
  let l:ft = "%{winwidth(0) > 70 ? (len(&filetype) ? &filetype : 'no ft') : ''}"
  " there's a glitch when using git branch cmd in statusline vim
  " let g:gitbranchcmd = "git branch --show-current 2>/dev/null | tr -d '\n'"
  " let l:git = "%{exists('*FugitiveHead') ? (winwidth(0) > 70 ? fugitive#head() : '') :
  "       \ (winwidth(0) > 70 ? system(g:gitbranchcmd) : '')}"
  let l:git = "%{winwidth(0) > 70 ? GitBranchName() : ''}"
  let l:sep = '%='
  let l:line = '  %3l/%L'
  let l:tab = "%{&expandtab ? ' sw='.&shiftwidth.' ' :
        \ &tabstop == &shiftwidth ? ' ts='.&tabstop.' ' :
        \ ' sw='.&shiftwidth.',ts='.&tabstop.' '}"
  let l:ses = "%{exists('g:current_possession') ? '[S]' : ''}"
  " useful for resolving git merge conflict or using diff more than 2 windows
  let l:diff = "%{&diff && winnr('$') > 2 ? ' [' . bufnr() . '] ' : '' }"
  if has('nvim')
    return w:mode.'%*'.l:tab.l:git.l:sep.l:diff.l:readonly.l:filename.l:mod.l:sep.l:ses.'  '.l:ft.l:line
  else
    return w:mode.'%*'.l:diff.l:tab.l:readonly.l:ses.l:filename.l:mod.l:sep.l:git.'  '.l:ft.l:line
  endif
endfunction

function! StatuslineNcComponent() abort
  let l:filename = " %{expand('%:p:~') ==# '' ? '[Blank]' :
        \ winwidth(0) > 160 ? expand('%:p:~') :
        \ winwidth(0) < 71 ? expand('%:t') :
        \ pathshorten(expand('%'))}"
  let l:readonly = '%r'
  let l:mod = "%{&modified ? '  [+]' : !&modifiable ? '  [-]' : ''}"
  let l:sep = '%='
  let l:diff = "%{&diff && winnr('$') > 2 ? ' [' . bufnr() . '] ' : '' }"
  if has('nvim')
    return l:sep.l:diff.l:readonly.l:filename.l:mod.l:sep
  else
    return l:diff.l:readonly.l:filename.l:mod.l:sep
  endif
endfunction

" Ref: https://github.com/itchyny/vim-gitbranch/blob/master/autoload/gitbranch.vim
function! GitBranchName() abort
  if get(b:, 'gitbranch_pwd', '') !=# expand('%:p:h') || !has_key(b:, 'gitbranch_path')
    call s:gitbranch_detect(expand('%:p:h'))
  endif
  if has_key(b:, 'gitbranch_path') && filereadable(b:gitbranch_path)
    let branch = get(readfile(b:gitbranch_path), 0, '')
    if branch =~# '^ref: '
      return substitute(branch, '^ref: \%(refs/\%(heads/\|remotes/\|tags/\)\=\)\=', '', '')
    elseif branch =~# '^\x\{20\}'
      return branch[:6]
    endif
  endif
  return ''
endfunction

function! s:gitbranch_dir(path) abort
  let path = a:path
  let prev = ''
  let git_modules = path =~# '/\.git/modules/'
  while path !=# prev
    let dir = path . '/.git'
    let type = getftype(dir)
    if type ==# 'dir' && isdirectory(dir.'/objects') && isdirectory(dir.'/refs') && getfsize(dir.'/HEAD') > 10
      return dir
    elseif type ==# 'file'
      let reldir = get(readfile(dir), 0, '')
      if reldir =~# '^gitdir: '
        return simplify(path . '/' . reldir[8:])
      endif
    elseif git_modules && isdirectory(path.'/objects') && isdirectory(path.'/refs') && getfsize(path.'/HEAD') > 10
      return path
    endif
    let prev = path
    let path = fnamemodify(path, ':h')
  endwhile
  return ''
endfunction

function! s:gitbranch_detect(path) abort
  unlet! b:gitbranch_path
  let b:gitbranch_pwd = expand('%:p:h')
  let dir = s:gitbranch_dir(a:path)
  if dir !=# ''
    let path = dir . '/HEAD'
    if filereadable(path)
      let b:gitbranch_path = path
    endif
  endif
endfunction

" let &cpo = s:save_cpo
" unlet s:save_cpo
