" decoupled vim session management
" Ref: https://github.com/mhinz/vim-startify/blob/81e36c352a8deea54df5ec1e2f4348685569bed2/autoload/startify.vim#L27
let g:possession_dir = get(g:, 'possession_dir',
      \ has('nvim-0.3.1') ?
      \ stdpath('data') . '/session' :
      \ has('nvim') ?
      \ '~/.local/share/nvim/session' :
      \ '~/.vim/session'
      \ )

let g:possession_git_root = !get(g:, 'possession_no_git_root') ?
      \ fnamemodify(
      \   trim(system('git rev-parse --show-toplevel 2>/dev/null')), ':p:s?\/$??'
      \ ) :
      \ getcwd()

let g:possession_git_branch = !get(g:, 'possession_no_git_branch') ?
      \ trim(system("git branch --show-current 2>/dev/null")) :
      \ ''

let g:possession_file_pattern = g:possession_dir . '/' . substitute(
      \ fnamemodify(g:possession_git_root, ':~:.'), '[\~\.\/]', '%', 'g'
      \ ) . (g:possession_git_branch !=# '' ? '%' . g:possession_git_branch : '')

" Ref: minpac/autoload/minpac/impl.vim
" TODO: need to simplify this
let replace_first_percentage = map(globpath(g:possession_dir, '%%*', 0, 1),
      \ {-> substitute(v:val, '^.*[/\\]%', '\~', '')})
let g:possession_list = map(
      \ map(replace_first_percentage,
      \   {-> substitute(v:val, '^\~%%', '\~%.', '')}),
      \ {-> substitute(v:val, '%', '\/', 'g')}
      \ )

command! -bang Possess
      \ call possession#init(<bang>0) |
      \ let replace_first_percentage = map(globpath(g:possession_dir, '%%*', 0, 1),
      \   {-> substitute(v:val, '^.*[/\\]%', '\~', '')}) |
      \ let g:possession_list = map(
      \   map(replace_first_percentage,
      \     {-> substitute(v:val, '^\~%%', '\~%.', '')}),
      \   {-> substitute(v:val, '%', '\/', 'g')}
      \   )

command! PList echo join(g:possession_list, "\n")
command! PMove
      \ call possession#move() |
      \ let replace_first_percentage = map(globpath(g:possession_dir, '%%*', 0, 1),
      \   {-> substitute(v:val, '^.*[/\\]%', '\~', '')}) |
      \ let g:possession_list = map(
      \   map(replace_first_percentage,
      \     {-> substitute(v:val, '^\~%%', '\~%.', '')}),
      \   {-> substitute(v:val, '%', '\/', 'g')}
      \   )

function! s:possession_load()
  let file = filereadable(expand(g:possession_git_root . '/Session.vim')) ?
        \ g:possession_git_root . '/Session.vim' :
        \ filereadable(expand(g:possession_file_pattern)) ?
        \ g:possession_file_pattern : ''
  if empty(v:this_session) && file !=# '' && !&modified
    exe 'source ' . fnameescape(file)
    " remove the echo of file name at startup, vim change the shortmess option
    " when using session temporary
    redraw
    let g:current_possession = v:this_session
    if bufexists(0) && !filereadable(bufname('#'))
      bw #
    endif
    echom 'Tracking session in ' . fnamemodify(g:current_possession, ':~:.')
  elseif !empty(v:this_session)
    echo 'There is another session going on'
  elseif &modified
    echo 'Please save the current buffer first'
  endif
endfunction

augroup possession
  autocmd!
  autocmd VimEnter * nested
        \ if !argc()                 |
        \   call s:possession_load() |
        \ endif
  autocmd VimLeavePre * call possession#persist()
augroup END
