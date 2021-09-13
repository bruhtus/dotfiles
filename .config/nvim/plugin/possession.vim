" simple session management
" Ref: https://github.com/tpope/vim-obsession/blob/master/plugin/obsession.vim

function! s:save_session()
  let l:root = systemlist('git rev-parse --show-toplevel')[0]

  if v:shell_error
    if exists('g:recording_session')
          \ && !exists('b:init_mksession')
          \ && filereadable('Session.vim')
      mks! Session.vim
    elseif exists('b:init_mksession') && !filereadable('Session.vim')
      mks Session.vim
      let g:recording_session = 1
      echom 'Not in git repo and recording session'
    endif
  else
    if exists('g:recording_session')
          \ && !exists('b:init_mksession')
          \ && filereadable(l:root . '/Session.vim')
      exe 'mks! ' . l:root . '/Session.vim'
    elseif exists('b:init_mksession') && !filereadable(l:root . '/Session.vim')
      exe 'mks ' . l:root . '/Session.vim'
      let g:recording_session = 1
      echom 'Recording session'
    endif
  endif
endfunction

" TODO: feature to add arguments for the command
" TODO: make confirm interface to override existing vim session or using CWD or
" do nothing
command! -bar -bang -complete=file -nargs=? Mksession
      \ if <bang>0 && !empty(v:this_session) && exists('g:recording_session') |
      \   call delete(v:this_session)                                         |
      \   unlet g:recording_session                                           |
      \   echom 'Session deleted'                                             |
      \ elseif <bang>0
      \ && (empty(v:this_session) || !exists('g:recording_session'))          |
      \   echo 'No session found'                                             |
      \ elseif !exists('g:recording_session')                                 |
      \   let b:init_mksession = 1                                            |
      \   call s:save_session()                                               |
      \   unlet b:init_mksession                                              |
      \ endif

augroup session
  autocmd!
  autocmd VimEnter * nested
        \ if !argc()
        \ && empty(v:this_session)
        \ && filereadable('Session.vim')
        \ && !&modified |
        \   let g:recording_session = 1 |
        \   source Session.vim          |
        \   echom 'Recording session'   |
        \   if bufexists(0) && !filereadable(bufname('#')) | bw # | endif |
        \ endif
  autocmd VimLeavePre * call s:save_session()
augroup END
