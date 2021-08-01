" reference:
" https://github.com/junegunn/dotfiles/blob/057ee47465e43aafbd20f4c8155487ef147e29ea/vimrc#L655-L667
" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" https://stackoverflow.com/a/38082196

function! root#toggle()
  if exists('b:root_enabled')
    unlet b:root_enabled
    unlet b:root_first_time
    execute 'lcd %:p:h'
    echo 'Root directory disabled'
  else
    let l:root = systemlist('git rev-parse --show-toplevel')[0]
    let l:nvim_root = finddir('nvim', escape(expand('%:p:h'), ' ') . ';')

    if v:shell_error
      if isdirectory(l:nvim_root)
        let b:root_enabled = 1
        execute 'lcd ' . l:nvim_root
        if !exists('b:root_first_time')
          let b:root_first_time = 1
          echo 'Changed directory to: ' . l:nvim_root
        endif
      else
        echo 'Not in git repo or neovim directory'
      endif
    else
      let b:root_enabled = 1
      execute 'lcd ' . l:root
      if !exists('b:root_first_time')
        let b:root_first_time = 1
        echo 'Changed directory to: ' . l:root
      endif
    endif

  endif
endfunction
