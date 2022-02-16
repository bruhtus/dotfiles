" Ref: https://github.com/tpope/vim-obsession/blob/master/plugin/obsession.vim
function! possession#init(bang) abort
  if !isdirectory(fnamemodify(g:possession_dir, ':p'))
    call mkdir(fnamemodify(g:possession_dir, ':p'), 'p')
  endif

  let session = get(g:, 'current_possession', v:this_session)

  try
    if a:bang && filereadable(expand(session))
      echom 'Deleting session in ' . fnamemodify(session, ':~:.')
      call delete(expand(session))
      unlet! g:current_possession
      return ''
    elseif a:bang && !filereadable(expand(session))
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
  exe 'pedit ' . g:possession_window_name
  wincmd P
  nnoremap <buffer> <silent> <nowait> q :<C-u>bw<CR>
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
    echom 'Deleting session ' . expand('<cfile>')
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
  let renamed = g:possession_git_root . '/Session.vim'

  if !filereadable(expand(renamed)) && filereadable(expand(g:possession_file_pattern))
    call rename(expand(g:possession_file_pattern), expand(renamed))
    let g:current_possession = renamed
    echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')

  elseif filereadable(expand(renamed)) && !filereadable(expand(g:possession_file_pattern))
    call rename(expand(renamed), expand(g:possession_file_pattern))
    let g:current_possession = g:possession_file_pattern
    echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')

  elseif filereadable(expand(renamed)) && filereadable(expand(g:possession_file_pattern))
    let choice = confirm('Session file exist, replace it?',
          \ "&Yes\n&No", 2)
    if choice == 1
      redraw
      let decide = confirm('Move from current working directory or possession directory?',
            \ "&Current working directory\n&Possession directory\n&Quit", 3)
      if decide == 1
        redraw
        call rename(expand(renamed), expand(g:possession_file_pattern))
        let g:current_possession = g:possession_file_pattern
        echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')
      elseif decide == 2
        redraw
        call rename(expand(g:possession_file_pattern), expand(renamed))
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
