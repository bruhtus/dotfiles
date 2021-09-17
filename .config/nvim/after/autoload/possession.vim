" Ref: https://github.com/tpope/vim-obsession/blob/master/plugin/obsession.vim
function! possession#init(bang) abort
  if !isdirectory(fnamemodify(g:possession_dir, ':p'))
    call mkdir(fnamemodify(g:possession_dir, ':p'), 'p')
  endif

  let session = get(g:, 'current_possession', v:this_session)

  try
    if a:bang && filereadable(session)
      echom 'Deleting session in ' . fnamemodify(session, ':~:.')
      call delete(session)
      if exists('g:current_possession') | unlet g:current_possession | endif
      return ''
    elseif a:bang && !filereadable(session)
      echo 'Session for this path not found, nothing deleted'
      return ''
    elseif exists('g:current_possession')
      echom 'Pausing session in ' . fnamemodify(session, ':~:.')
      unlet g:current_possession
      return ''
    elseif !empty(session)
      let file = session
    else
      let file = g:possession_file_pattern
    endif

    let g:current_possession = file

    let error = possession#persist()
    if empty(error)
      echom 'Tracking session in ' . fnamemodify(file, ':~:.')
      let v:this_session = file
      return ''
    else
      return error
    endif

  finally
    let &l:readonly = &l:readonly
  endtry
endfunction

function! possession#persist() abort
  if exists('g:SessionLoad')
    return ''
  endif

  if exists('g:current_possession')
    try
      exe 'mksession! ' . fnameescape(g:current_possession)
    catch
      unlet g:current_possession
      let &l:readonly = &l:readonly
      return 'echoerr ' . string(v:exception)
    finally
      let &l:readonly = &l:readonly
    endtry
  endif
  return ''
endfunction

function! possession#move() abort
  let l:renamed = g:possession_git_root . '/Session.vim'

  if !filereadable(expand(l:renamed)) && filereadable(expand(g:possession_file_pattern))
    call rename(expand(g:possession_file_pattern), expand(l:renamed))
    let g:current_possession = l:renamed
    echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')

  elseif filereadable(expand(l:renamed)) && !filereadable(expand(g:possession_file_pattern))
    call rename(expand(l:renamed), expand(g:possession_file_pattern))
    let g:current_possession = g:possession_file_pattern
    echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')

  elseif filereadable(expand(l:renamed)) && filereadable(expand(g:possession_file_pattern))
    let l:choice = confirm('Session file exist, replace it?',
          \ "&Yes\n&No", 2)
    if l:choice == 1
      redraw
      let l:decide = confirm('Move from current working directory or possession directory?',
            \ "&Current working directory\n&Possession directory\n&Quit", 3)
      if l:decide == 1
        redraw
        call rename(expand(l:renamed), expand(g:possession_file_pattern))
        let g:current_possession = g:possession_file_pattern
        echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')
      elseif l:decide == 2
        redraw
        call rename(expand(g:possession_file_pattern), expand(l:renamed))
        let g:current_possession = l:renamed
        echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')
      elseif l:decide == 3
        redraw
        echo 'Canceled, no session file moved'
      endif
    elseif l:choice == 2
      redraw
      echo 'No session file moved'
    endif

  else
    echo 'No session found for this path'
  endif
  let v:this_session = g:current_possession
endfunction
