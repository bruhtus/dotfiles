" decoupled vim session management
" Ref: https://github.com/mhinz/vim-startify/blob/81e36c352a8deea54df5ec1e2f4348685569bed2/autoload/startify.vim#L27

let g:possession_window_name = get(g:, 'possession_window_name',
      \ 'possession')

let g:possession_dir = get(g:, 'possession_dir',
      \ '~/.local/share/vim/session'
      \ )

" Note: remove the last slice in directory path
" let g:possession_git_root = !get(g:, 'possession_no_git_root') ?
"       \ fnamemodify(
"       \   trim(system('git rev-parse --show-toplevel 2>/dev/null')), ':p:s?\/$??'
"       \ ) :
"       \ getcwd()

" Note: GitDir() function on statusline.vim
function! PossessionGitRoot() abort
  if !get(g:, 'possession_no_git_root')
    let l:dir = GitDir(getcwd())
    return !empty(l:dir) ?
          \ fnamemodify(l:dir, ':h') :
          \ getcwd()
  endif

  return getcwd()
endfunction

" let g:possession_git_branch = !get(g:, 'possession_no_git_branch') ?
"       \ trim(system("git branch --show-current 2>/dev/null")) :
"       \ ''

" Note: GitBranch() function on statusline.vim
function! PossessionGitBranch() abort
  if !get(g:, 'possession_no_git_branch')
    return GitBranch()
  endif

  return ''
endfunction

" Note: change `~`, `.`, and `/` in directory to `%`
" let g:possession_file_pattern = g:possession_dir . '/' . substitute(
"       \ fnamemodify(g:possession_git_root, ':.'), '[\.\/]', '%', 'g'
"       \ ) . (g:possession_git_branch !=# '' ?
"       \ '%' . substitute(g:possession_git_branch, '\/', '%', 'g') : '')

function! PossessionFilePattern(...) abort
  let l:dir = get(a:000, 0)
  let l:branch = get(a:000, 1)

  if !empty(l:dir)
    return g:possession_dir . '/' . substitute(
          \ fnamemodify(l:dir, ':.'), '[\.\/]', '%', 'g'
          \ ) . (l:branch !=# '' ?
          \ '%' . substitute(l:branch, '\/', '%', 'g') : '')
  endif

  return g:possession_dir . '/' . substitute(
      \ fnamemodify(PossessionGitRoot(), ':.'), '[\.\/]', '%', 'g'
      \ ) . (PossessionGitBranch() !=# '' ?
      \ '%' . substitute(PossessionGitBranch(), '\/', '%', 'g') : '')
endfunction

command! -bang Possess
      \ call possession#init(<bang>0) |
      \ call possession#refresh_list()

command! PList
      \ call possession#show_list()

command! PMove
      \ call possession#move() |
      \ call possession#refresh_list()

" Ref: vim-lsp/autoload/lsp/utils.vim (lsp#utils#echo_with_truncation())
function! PossessionMsgTruncation(msg) abort
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
  if filereadable(expand(getcwd() . '/Session.vim'))
    let file = getcwd() . '/Session.vim'
  elseif filereadable(expand(PossessionFilePattern(getcwd(), PossessionGitBranch())))
    let file = PossessionFilePattern(getcwd(), PossessionGitBranch())
  elseif filereadable(expand(PossessionGitRoot() . '/Session.vim'))
    let file = PossessionGitRoot() . '/Session.vim'
  elseif filereadable(expand(PossessionFilePattern()))
    let file = PossessionFilePattern()
  else
    let file = ''
  endif

  if empty(v:this_session) && file !=# '' && !&modified
    exe 'silent source ' . fnameescape(file)
    let g:current_possession = v:this_session
    if bufexists(0) && !filereadable(bufname('#'))
      bw #
    endif

    " " Note: reload all visible buffer.
    " let l:temp_undoreload = &undoreload
    " let &undoreload = 0
    " windo e
    " let &undoreload = l:temp_undoreload

    " Note:
    " make sure that the echo message appear when using this with VimEnter
    " autocmd event
    redraw

    echom 'Loading session in '
          \ . PossessionMsgTruncation(fnamemodify(g:current_possession, ':~:.'))
  elseif !empty(v:this_session)
    echo 'There is another session going on'
  elseif &modified
    echo 'Please save the current buffer first'
  endif
endfunction

function! PossessionPersist() abort
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
  autocmd VimEnter * nested ++once
        \ if !argc()                 |
        \   call s:possession_load() |
        \ endif
  autocmd VimLeavePre * call PossessionPersist()
augroup END
