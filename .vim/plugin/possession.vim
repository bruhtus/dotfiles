" decoupled vim session management
" Ref: https://github.com/mhinz/vim-startify/blob/81e36c352a8deea54df5ec1e2f4348685569bed2/autoload/startify.vim#L27

let g:possession_window_name = get(g:, 'possession_window_name',
      \ 'possession')

let g:possession_dir = get(g:, 'possession_dir',
      \ has('nvim-0.3.1') ?
      \ stdpath('data') . '/session' :
      \ has('nvim') ?
      \ '~/.local/share/nvim/session' :
      \ '~/.local/share/vim/session'
      \ )

" Note: remove the last slice in directory path
let g:possession_git_root = !get(g:, 'possession_no_git_root') ?
      \ fnamemodify(
      \   trim(system('git rev-parse --show-toplevel 2>/dev/null')), ':p:s?\/$??'
      \ ) :
      \ getcwd()

let g:possession_git_branch = !get(g:, 'possession_no_git_branch') ?
      \ trim(system("git branch --show-current 2>/dev/null")) :
      \ ''

" Note: change `~`, `.`, and `/` in directory to `%`
let g:possession_file_pattern = g:possession_dir . '/' . substitute(
      \ fnamemodify(g:possession_git_root, ':.'), '[\.\/]', '%', 'g'
      \ ) . (g:possession_git_branch !=# '' ?
      \ '%' . substitute(g:possession_git_branch, '\/', '%', 'g') : '')

command! -bang Possess
      \ call possession#init(<bang>0) |
      \ call possession#refresh_list()

command! PList
      \ call possession#show_list()

command! PMove
      \ call possession#move() |
      \ call possession#refresh_list()

" Ref: vim-lsp/autoload/lsp/utils.vim (lsp#utils#echo_with_truncation())
function! possession#msg_truncation(msg) abort
  let l:msg = a:msg

  if &laststatus == 0 || (&laststatus == 1 && winnr('$') == 1)
    let l:winwidth = winwidth(0)

    if &ruler
      let l:winwidth -= 18
    endif
  else
    let l:winwidth = &columns - 20
  endif

  if &showcmd
    let l:winwidth -= 12
  endif

  if l:winwidth > 5 && l:winwidth < strdisplaywidth(a:msg)
    let l:msg = l:msg[:l:winwidth - 5] . '...'
  endif

  return l:msg
endfunction

function! s:possession_load() abort
  let file = filereadable(expand(g:possession_git_root . '/Session.vim')) ?
        \ g:possession_git_root . '/Session.vim' :
        \ filereadable(expand(g:possession_file_pattern)) ?
        \ g:possession_file_pattern : ''
  if empty(v:this_session) && file !=# '' && !&modified
    exe 'source ' . fnameescape(file)
    " Note: remove the echo of file name at startup, vim change the shortmess option
    " when using session temporary
    redraw
    let g:current_possession = v:this_session
    if bufexists(0) && !filereadable(bufname('#'))
      bw #
    endif
    echom 'Loading session in '
          \ . possession#msg_truncation(fnamemodify(g:current_possession, ':~:.'))
  elseif !empty(v:this_session)
    echo 'There is another session going on'
  elseif &modified
    echo 'Please save the current buffer first'
  endif
endfunction

function! possession#persist() abort
  " Note: more info :h SessionLoad-variable
  " Note: can also be used to not save the session
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

augroup possession
  autocmd!
  autocmd VimEnter * nested
        \ if !argc()                 |
        \   call s:possession_load() |
        \ endif
  autocmd VimLeavePre * call possession#persist()
augroup END
