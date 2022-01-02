" Ref:
" https://github.com/junegunn/dotfiles/blob/057ee47465e43aafbd20f4c8155487ef147e29ea/vimrc#L655-L667
" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" https://stackoverflow.com/a/38082196

function! s:search_root(pattern)
  for l:root in a:pattern
    " Note: prioritize git worktree and git submodules.
    if !empty(findfile(l:root, escape(expand('%:p:h'), ' ') . ';'))
      let l:path =
            \ fnamemodify(
            \   findfile(l:root, escape(expand('%:p:h'), ' ') . ';'),
            \ ':h')
      return l:path
    elseif !empty(finddir(l:root, escape(expand('%:p:h'), ' ') . ';'))
      " Note: special treatment for dot directory because we want to change
      " directory into the pattern directory, not the directory above the
      " pattern directory, unless it's a dot directory like `.git`.
      " Flaw: can't change into the dot directory itself, like `.vim`.
      let l:path =
            \ l:root[0] ==# '.' ?
            \ fnamemodify(
            \   finddir(l:root, escape(expand('%:p:h'), ' ') . ';'),
            \ ':h') :
            \ finddir(l:root, escape(expand('%:p:h'), ' ') . ';')
      return l:path
    endif
  endfor
  return ''
endfunction

function! root#toggle()
  if exists('b:root_enabled')
    unlet b:root_enabled b:root_first_time
    execute 'lcd %:p:h'
    echo 'Root directory disabled'

  else
    let g:root_pattern = ['.git', 'nvim', 'vimrc']
    let l:root_path = s:search_root(g:root_pattern)

    let g:root_extra_pattern = get(g:, 'root_extra_pattern', '')

    " Note: add extra pattern on the go.
    " Usage: let g:root_extra_pattern = 'nvim'
    " TODO: find a better interface.
    if !empty(g:root_extra_pattern)
      call insert(g:root_pattern,
            \ g:root_extra_pattern
            \ )
      let l:root_path = s:search_root(g:root_pattern)
    endif

    if !empty(l:root_path)
      if l:root_path !=# '.' && l:root_path !=# expand('%:p:h')
        let b:root_enabled = 1
        execute 'lcd ' . l:root_path
        if !exists('b:root_first_time')
          let b:root_first_time = 1
          echo 'Changed directory to: ' . l:root_path
        endif
      else
        echo 'Already in root'
      endif
    else
      echo 'Root not found'
    endif

    " let l:root = systemlist('git rev-parse --show-toplevel')[0]
    " let l:vim_root = has('nvim') ? finddir('nvim', escape(expand('%:p:h'), ' ') . ';') :
    "       \ fnamemodify(findfile('vimrc', escape(expand('%:p:h'), ' ') . ';'), ':h')

    " if v:shell_error
    "   if isdirectory(l:vim_root) && l:vim_root !=# '.'
    "     let b:root_enabled = 1
    "     execute 'lcd ' . l:vim_root
    "     if !exists('b:root_first_time')
    "       let b:root_first_time = 1
    "       echo 'Changed directory to: ' . l:vim_root
    "     endif
    "   else
    "     echo 'Not in git repo or (n)vim directory'
    "   endif
    " else
    "   let b:root_enabled = 1
    "   execute 'lcd ' . l:root
    "   if !exists('b:root_first_time')
    "     let b:root_first_time = 1
    "     echo 'Changed directory to: ' . l:root
    "   endif
    " endif

  endif
endfunction

function! root#temp()
  let l:root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd ' . l:root
  endif
endfunction
