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
