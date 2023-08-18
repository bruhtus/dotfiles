function! enable#fzf#init()
  if !exists('g:loaded_fzf_vim')
    packadd fzf | packadd fzf.vim

    " disable ruler when open fzf window in vim
    if !has('nvim')
      autocmd! FileType fzf
            \ let b:ruler = &ruler  |
            \ set noruler           |
            \  autocmd BufLeave <buffer>
            \  let &ruler = b:ruler |
            \  unlet b:ruler
    endif

    " move preview half page-up/down using ctrl-p/n
    " ctrl-b/f useful to move the cursor to the left/right
    " wrap preview content
    let $FZF_DEFAULT_OPTS = "--bind ctrl-n:preview-half-page-down,ctrl-p:preview-half-page-up --preview-window=wrap,hidden"

    let g:fzf_action = {
          \ 'ctrl-t': 'tab split',
          \ 'ctrl-x': 'split',
          \ 'ctrl-s': 'leftabove vsplit',
          \ 'ctrl-d': 'belowright vsplit'
          \ }

    " Ref: https://github.com/junegunn/fzf.vim/issues/942
    " More Info: `:h fzf-examples`
    let g:fzf_layout = {
          \ 'window': {
          \   'width': 1,
          \   'height': 0.5,
          \   'yoffset': 0,
          \   'border': 'bottom' }}

    " safety measure if ripgrep not installed
    if executable('rg')
      let $FZF_DEFAULT_COMMAND = "rg --hidden --files --no-ignore-vcs --type-not nonsense --type-not font --type-not torrent"

      " exclude filenames when using Rg
      " Ref: https://github.com/junegunn/fzf.vim/issues/714#issuecomment-428802659
      command! -bang -nargs=* CustomRg
            \ call fzf#vim#grep(
            \ "rg --column --line-number --no-heading --color=always --smart-case -- " . shellescape(<q-args>),
            \ 1,
            \ winheight(0) < 40 ? fzf#vim#with_preview(
            \ {'options': '--with-nth=1,4.. --delimiter : --nth 2..'},
            \ 'hidden', 'ctrl-/') :
            \ winwidth(0) < 192 && winnr('$') == 1 ? fzf#vim#with_preview(
            \ {'options': '--with-nth=1,4.. --delimiter : --nth 2..'},
            \ 'up:50%:hidden', 'ctrl-/') :
            \ fzf#vim#with_preview(
            \ {'options': '--with-nth=1,4.. --delimiter : --nth 2..'},
            \ 'hidden', 'ctrl-/'), <bang>0)

      command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \ "rg --column --line-number --no-heading --color=always --smart-case -- " . shellescape(<q-args>),
            \ 1,
            \ winheight(0) < 40 ? fzf#vim#with_preview(
            \ {'options': '--with-nth=1,4.. --delimiter :'},
            \ 'hidden', 'ctrl-/') :
            \ winwidth(0) < 192 && winnr('$') == 1 ? fzf#vim#with_preview(
            \ {'options': '--with-nth=1,4.. --delimiter :'},
            \ 'up:50%:hidden', 'ctrl-/') :
            \ fzf#vim#with_preview(
            \ {'options': '--with-nth=1,4.. --delimiter :'},
            \ 'hidden', 'ctrl-/'), <bang>0)

      " Custom BLines with preview (using ripgrep)
      " Ref: https://github.com/junegunn/fzf.vim/issues/374#issuecomment-724301156
      command! -bang -nargs=* CustomBLines
            \ call fzf#vim#grep(
            \ 'rg --with-filename --column --line-number --no-heading --smart-case . ' . fnameescape(expand('%:p')),
            \ 1,
            \ winheight(0) < 40 ? fzf#vim#with_preview(
            \ {'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=2,4.. --tiebreak=index --delimiter : --nth 2..'}, 'hidden', 'ctrl-/') :
            \ winwidth(0) < 192 ? fzf#vim#with_preview(
            \ {'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=2,4.. --tiebreak=index --delimiter : --nth 2..'}, 'up:50%:hidden', 'ctrl-/') :
            \ fzf#vim#with_preview({'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=2,4.. --tiebreak=index --delimiter : --nth 2..'}, 'hidden', 'ctrl-/'))
      " \   fzf#vim#with_preview({'options': '--layout reverse-list  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))
    endif

    " preview at the top when winwidth less than 192
    " and at the right when winheight less than 40
    command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>,
          \ winheight(0) < 40 ? fzf#vim#with_preview('hidden', 'ctrl-/') :
          \ winwidth(0) < 192 && winnr('$') == 1 ? fzf#vim#with_preview('up:50%:hidden', 'ctrl-/') :
          \ fzf#vim#with_preview('hidden', 'ctrl-/'), <bang>0)

  endif
endfunction
