" Ref: https://github.com/tpope/vim-obsession/blob/master/plugin/obsession.vim
function! possession#init(bang) abort
  if !isdirectory(fnamemodify(g:possession_dir, ':p'))
    call mkdir(fnamemodify(g:possession_dir, ':p'), 'p')
  endif

  let l:session = get(g:, 'current_possession', v:this_session)

  try
    if a:bang && filereadable(expand(l:session))
      echom 'Deleting session in '
            \ . PossessionMsgTruncation(fnamemodify(l:session, ':~:.'))
      call delete(expand(l:session))
      unlet! g:current_possession
      let v:this_session = ''
      unlet l:session
      return ''
    elseif a:bang && !filereadable(expand(l:session))
      echo 'Session for this path not found, nothing deleted'
      return ''
    elseif exists('g:current_possession')
      echom 'Pausing session in '
            \ . PossessionMsgTruncation(fnamemodify(l:session, ':~:.'))
      unlet g:current_possession
      return ''
    elseif !empty(l:session)
      let l:file = l:session
    else
      let l:file = PossessionFilePattern()
    endif

    let g:current_possession = l:file

    let error = PossessionPersist()
    if empty(error)
      echom 'Tracking session in '
            \ . PossessionMsgTruncation(fnamemodify(l:file, ':~:.'))
      let v:this_session = l:file
      return ''
    else
      return error
    endif

  finally
    let &l:readonly = &l:readonly
  endtry
endfunction

" Ref: minpac/autoload/minpac/impl.vim
" TODO: need to simplify this
" Note: change back the `%` to its respective symbol
function! possession#refresh_list() abort
  let replace_first_percentage = map(globpath(g:possession_dir, '%*', 0, 1),
        \ {-> substitute(v:val, '^.*[/\\]%', '\/', '')})

  let g:possession_list = map(
        \ map(replace_first_percentage,
        \   {-> substitute(v:val, '%', '\/', 'g')}),
        \ {-> substitute(v:val, '\/\/', '\/.', '')}
        \ )
endfunction

function! s:set_options()
  setlocal number norelativenumber
  setlocal bufhidden=wipe buftype=nofile nobuflisted
  setlocal foldcolumn=0 nofoldenable
  setlocal noswapfile nomodifiable nowrap
  setlocal colorcolumn=
endfunction

function! possession#show_list() abort
  call possession#refresh_list()
  exe 'botright pedit ' . g:possession_window_name
  wincmd P
  nnoremap <buffer> <silent> <nowait> q :<C-u>bw <Bar> wincmd p<CR>
  nnoremap <buffer> <silent> <nowait> d <C-d>
  nnoremap <buffer> <silent> u <C-u>
  nnoremap <buffer> <silent> D :<C-u>call possession#delete_session()<CR>
  call setline(1, g:possession_list)
  call s:set_options()
endfunction

function! possession#delete_session() abort
  let l:session_name = substitute(expand('<cfile>'), '[\.\/]', '%', 'g')
  let l:session_path = g:possession_dir . '/' . l:session_name

  let l:choice = confirm('Do you want to delete session ' . expand('<cfile>') . '?',
        \ "&Yes\n&No", 2)

  if l:choice == 1
    redraw
    echom 'Deleting session ' . PossessionMsgTruncation(expand('<cfile>'))
    call remove(g:possession_list, line('.')-1)
    call delete(expand(l:session_path))
    setlocal modifiable
    delete _
    setlocal nomodifiable
    if exists('g:current_possession') && expand(g:current_possession) ==# expand(l:session_path)
      unlet! g:current_possession
    endif

  elseif l:choice == 2
    redraw
    echo 'No session deleted'
  endif
endfunction

function! possession#move() abort
  let renamed = PossessionGitRoot() . '/Session.vim'

  " Note: from session file in possession dir to Session.vim in current dir.
  if !filereadable(expand(renamed)) && filereadable(expand(PossessionFilePattern()))
    call rename(expand(PossessionFilePattern()), expand(renamed))
    let g:current_possession = renamed
    echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')

  " Note: from Session.vim in current dir to session file in possession dir.
  elseif filereadable(expand(renamed)) && !filereadable(expand(PossessionFilePattern()))
    call rename(expand(renamed), expand(PossessionFilePattern()))
    let g:current_possession = PossessionFilePattern()
    echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')

  " Note:
  " from current possession filename in possession dir to current file
  " pattern.
  " useful if we want to change git branch or git root on the go.
  elseif !filereadable(PossessionFilePattern()) && filereadable(expand(g:current_possession))
    call rename(expand(g:current_possession), expand(PossessionFilePattern()))
    let g:current_possession = PossessionFilePattern()
    echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')

  elseif filereadable(expand(renamed)) && filereadable(expand(PossessionFilePattern()))
    let choice = confirm('Session file exist, replace it?',
          \ "&Yes\n&No", 2)
    if choice == 1
      redraw
      let decide = confirm('Move from current working directory or possession directory?',
            \ "&Current working directory\n&Possession directory\n&Quit", 3)
      if decide == 1
        redraw
        call rename(expand(renamed), expand(PossessionFilePattern()))
        let g:current_possession = PossessionFilePattern()
        echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')
      elseif decide == 2
        redraw
        call rename(expand(PossessionFilePattern()), expand(renamed))
        let g:current_possession = renamed
        echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')
      elseif decide == 3
        redraw
        echo 'Canceled, no session file moved'
      endif
    elseif choice == 2
      redraw
      echo 'No session file moved'
    endif

  else
    echo 'No session found for this path'
  endif
  if exists('g:current_possession')
    let v:this_session = g:current_possession
  endif
endfunction
