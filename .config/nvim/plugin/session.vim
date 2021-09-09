" simple session management
" Ref: https://github.com/tpope/vim-obsession/blob/master/plugin/obsession.vim

function! s:save_session()
  let l:root = systemlist('git rev-parse --show-toplevel')[0]

  if v:shell_error
    if exists('g:recording_session')
          \ && !exists('b:init_mksession')
          \ && filereadable('Session.vim')
          \ && !&modified
      mks! Session.vim
    elseif exists('b:init_mksession')
          \ && !filereadable('Session.vim')
          \ && !&modified
      mks Session.vim
      let g:recording_session = 1
      echom 'Not git repo and recording session'
    else
      echo 'Session exist'
    endif
  else
    if exists('g:recording_session')
          \ && !exists('b:init_mksession')
          \ && filereadable(l:root . '/Session.vim')
          \ && !&modified
      exe 'mks! ' . l:root . '/Session.vim'
    elseif exists('b:init_mksession')
          \ && !filereadable(l:root . '/Session.vim')
          \ && !&modified
      exe 'mks ' . l:root . '/Session.vim'
      let g:recording_session = 1
      echom 'Recording session'
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
  autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') && !&modified |
        \   let g:recording_session = 1 |
        \   source Session.vim |
        \   echom 'Recording session' |
        \   if bufexists(0) && !filereadable(bufname('#')) | bw # | endif |
        \ endif

augroup END
