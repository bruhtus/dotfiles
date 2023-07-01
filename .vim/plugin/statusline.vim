" statusline config

" why would you want to load this if you don't want to use statusline?
if !&laststatus
  if !&showmode | set showmode! | endif
  finish
endif

set statusline=%!StatuslineActive()

" Ref: https://github.com/junegunn/dotfiles/blob/057ee47465e43aafbd20f4c8155487ef147e29ea/vimrc#L265-L275
function! StatuslineActive() abort
  " let l:mode = "%{%statusline#mode()%}"
  " let l:filename = " %{expand('%:p:~') ==# '' ? '[Blank]' :
  "       \ winwidth(0) > 160 ? expand('%:p:~') :
  "       \ winwidth(0) < 71 ? expand('%:t') :
  "       \ pathshorten(expand('%'))}"

  let l:filename = ' %#Statusline#%<%f%*'
  let l:readonly = '%r'

  " let l:mod = "%{&modified ? '  [+]' : !&modifiable ? '  [-]' : ''}"
  let l:mod = ' %m'

  " let l:ft = "%{winwidth(0) > 70 ? ' ' . (len(&filetype) ? &filetype : 'no ft') : ''}"
  let l:ft = '%y'

  " there's a glitch when using git branch cmd in statusline vim
  " let g:gitbranchcmd = "git branch --show-current 2>/dev/null | tr -d '\n'"
  " let l:git = "%{exists('*FugitiveHead') ? (winwidth(0) > 70 ? fugitive#head() : '') :
  "       \ (winwidth(0) > 70 ? system(g:gitbranchcmd) : '')}"
  " Note: truncate from the right.
  " Ref: https://stackoverflow.com/a/20899652
  " let l:git = "  %([%{winwidth(0) > 70 ? strpart(GitBranch(), 0, 20) : ''}]%)"
  let l:git = "  %([%{winwidth(0) > 100 ? GitBranch() :
        \ winwidth(0) > 70 ?
        \ (strlen(GitBranch()) > 10 ? '...' . GitBranch()[-7:]
        \ : GitBranch())
        \ : ''}]%)"

  let l:sep = '%='

  " current line/total lines:cursor column percentage in file
  let l:line = ' %-13.(%l/%L:%c%) %-4P'

  let l:indent = "%{
        \ (exists('b:editorconfig_file') && !empty(b:editorconfig_file))
        \   && &expandtab ?
        \ ' sw='.&shiftwidth.'* ' :
        \ (exists('b:editorconfig_file') && !empty(b:editorconfig_file))
        \   && !&expandtab && &tabstop == &shiftwidth ?
        \ ' ts='.&tabstop.'* ' :
        \ (exists('b:editorconfig_file') && !empty(b:editorconfig_file))
        \   && !&expandtab && &tabstop != &shiftwidth ?
        \ ' sw='.&shiftwidth.',ts='.&tabstop.'* ' :
        \ &expandtab ? ' sw='.&shiftwidth.' ' :
        \ &tabstop == &shiftwidth ? ' ts='.&tabstop.' ' :
        \ ' sw='.&shiftwidth.',ts='.&tabstop.' '}"

  let l:ses = "%{exists('g:current_possession') ? '[S]' : ''}"

  " useful for resolving git merge conflict or using diff more than 2 windows
  let l:diff = "%{&diff && winnr('$') > 2 ? ' [' . bufnr() . '] ' : '' }"

  " check if there's alternate buffer or not
  " let l:alt = "%{bufnr('#') == '-1' ? '' : '[#]'}"

  " Ref: https://superuser.com/a/345593
  let l:totalbuf = "%{'[' . len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) . ']'}"
  let l:root = "%{winwidth(0) > 80 && exists('b:root_enabled') ? '[/]' : ''}"

  " if has('nvim')
  "   return w:mode.'%*'.l:indent.l:git.l:sep.l:diff.l:readonly.l:filename.l:mod.l:sep.l:ses.'  '.l:ft.l:line
  " else
    " return l:mode.'%*'.l:diff.l:indent.l:totalbuf.l:alt.l:ses.l:readonly.l:filename.l:mod.l:sep.l:git.'  '.l:ft.l:line
    return l:diff.l:indent.l:totalbuf.l:root.l:ses.l:readonly.l:filename.l:mod.l:sep.l:git.l:ft.l:line
  " endif
endfunction

" Ref: https://github.com/itchyny/vim-gitbranch/blob/master/autoload/gitbranch.vim
" Check: https://github.com/itchyny/vim-gitbranch/pull/9
function! GitBranch() abort
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

function! GitDir(path) abort
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
        return simplify(reldir[8:])
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
  let dir = GitDir(a:path)
  if dir !=# ''
    let path = dir . '/HEAD'
    if filereadable(path)
      let b:gitbranch_path = path
    endif
  endif
endfunction

" if has('patch-8.1.1372')
"   function! StatuslineUpdate(winid) abort
"     if a:winid == win_getid()
"       return StatuslineActive()
"     else
"       return StatuslineInactive()
"     endif
"   endfunction

"   " Ref:
"   " https://teddit.net/r/vim/comments/nyrv7c/how_to_use_different_statuslines_for_active_and/
"   " Ref:
"   " https://github.com/lacygoill/vim-statusline/blob/b9f9e84d840ed74ded8144adf50bb05b08c2408a/plugin/statusline.vim#L433-L447
"   " WARNING: this method only works on vim 8.1.1372 or above
"   " Patch:
"   " https://github.com/vim/vim/commit/1c6fd1e100fd0457375642ec50d483bcc0f61bb2
"   " Note: this method solve the problem when enter vim using split window like
"   " when use `git mergetool` command, the inactive statusline is not updated
"   " when using autocmd
"   set statusline=%!StatuslineUpdate(g:statusline_winid)

" else
"   " Ref:
"   " https://github.com/itchyny/lightline.vim/blob/a29b8331e1bb36b09bafa30c3aa77e89cdd832b2/autoload/lightline.vim#L21-L25
"   function! StatuslineUpdate() abort
"     let winnr = winnr()
"     let current_win =
"           \ winnr('$') == 1 && winnr > 0 ?
"           \ [StatuslineActive()] :
"           \ [StatuslineActive(), StatuslineInactive()]
"     for num in range(1, winnr('$'))
"       call setwinvar(num, '&statusline', current_win[num != winnr])
"     endfor
"   endfunction

"   augroup statusline_startup
"     autocmd!
"     autocmd WinEnter,BufEnter,SessionLoadPost,FileChangedShellPost *
"           \ call StatuslineUpdate()

"     "   maybe should have used ModeChanged event instead?
"     "   not sure if i should add more autocommand
"     "   autocmd CmdlineLeave :
"     "         \ if &laststatus != 2 && !&showmode |
"     "         \ set showmode |
"     "         \ else |
"     "         \ set noshowmode |
"     "         \ endif
"   augroup END
" endif

" function! statusline#mode() abort
"   if g:colors_name ==# 'seoul256mod'
"         \ && &laststatus == 2
"         \ && !&showmode
"     if mode() ==# 'n'
"       return '%#NormalModeColor# '
"     " Note: v:insertmode only display the last mode that trigger `InsertEnter` and
"     " `InsertChange`. maybe kind of similar to visualmode()? more info: `:h v:insertmode`
"     " Ref: https://gist.github.com/autrimpo/f40e4eda233977dd3a619c6083d9bebd
"     elseif mode() =~# '\v(i|R|Rv)'
"       return '%#InsertModeColor# '
"     elseif mode() =~# '\v(v|V|s|S)'
"           \ || mode() ==# "\<C-V>"
"           \ || mode() ==# "\<C-S>"
"       return '%#VisualModeColor# '
"     elseif mode() =~# '\v(c|t)'
"       return '%#CommandModeColor# '
"     endif

"   else
"     if !&showmode | set showmode! | endif
"     return ''
"   endif
" endfunction

" function! StatuslineInactive() abort
"   " let l:filename = " %{expand('%:p:~') ==# '' ? '[Blank]' :
"   "       \ winwidth(0) < 71 ? expand('%:t') :
"   "       \ expand('%:p:~')}"

"   let l:filename = ' %f'
"   let l:readonly = '%r'
"   let l:mod = ' %m'

"   " let l:mod = "%{&modified ? '  [+]' : !&modifiable ? '  [-]' : ''}"

"   let l:sep = '%='
"   let l:diff = "%{&diff && winnr('$') > 2 ? ' [' . bufnr() . '] ' : '' }"

"   " let l:root = "%{exists('b:root_enabled') ? '[/]' : ''}"
"   " if has('nvim')
"   "   return l:sep.l:diff.l:readonly.l:filename.l:mod.l:sep
"   " else
"     return l:diff.l:readonly.l:filename.l:mod.l:sep
"   endif
" endfunction
