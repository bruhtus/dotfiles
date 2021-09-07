" simple session management
" Ref: https://github.com/tpope/vim-obsession/blob/master/plugin/obsession.vim

function! s:open_session()
  let l:root = systemlist('git rev-parse --show-toplevel')[0]

  if v:shell_error
    if !argc() && empty(v:this_session) && filereadable('Session.vim') && !&modified
      source Session.vim
    endif
  else
    if !argc() && empty(v:this_session) && filereadable(l:root . '/Session.vim') && !&modified
      exe 'source ' . l:root . '/Session.vim'
      " delete alternate buffer if the file didn't exist
      " because of different CWD, vim think that we want to open
      " the same file as alternate buffer in CWD which most of the time didn't
      " exists
      if bufexists(0) && !filereadable(bufnr('$'))
        bw #
      endif
    endif
  endif
endfunction

function! s:save_session()
  let l:root = systemlist('git rev-parse --show-toplevel')[0]

  if v:shell_error
    if !exists('b:init_mksession') && filereadable('Session.vim') && !&modified
      mks! Session.vim
    elseif exists('b:init_mksession') && !filereadable('Session.vim') && !&modified
      mks Session.vim
      echo 'Session saved'
    else
      echo 'Session exist'
    endif
  else
    if !exists('b:init_mksession') && filereadable(l:root . '/Session.vim') && !&modified
      exe 'mks! ' . l:root . '/Session.vim'
    elseif exists('b:init_mksession') && !filereadable(l:root . '/Session.vim') && !&modified
      exe 'mks ' . l:root . '/Session.vim'
      echo 'Session saved'
    else
      echo 'Session exist'
    endif
  endif
endfunction

command! -bar -complete=file Dsession
      \ if !empty(v:this_session)     |
      \   call delete(v:this_session) |
      \   echo 'Session deleted'      |
      \ else                          |
      \   echo 'No session found'     |
      \ endif

command! -bar -complete=file Mksession
      \ let b:init_mksession = 1 |
      \ call s:save_session()    |
      \ unlet b:init_mksession

augroup session
  autocmd!
  autocmd VimEnter * nested call s:open_session()
  autocmd VimLeavePre * call s:save_session()
augroup END
