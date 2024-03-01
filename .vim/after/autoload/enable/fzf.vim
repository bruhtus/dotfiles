function! enable#fzf#init()
  if !exists('g:loaded_fzf_vim')
    packadd fzf | packadd fzf.vim

    " disable ruler when open fzf window in vim
    " augroup fzf_buffers
    "   autocmd! FileType fzf
    "         \ let g:before_fzf_ruler = &ruler |
    "         \ let g:before_fzf_laststatus = &laststatus |
    "         \ set noruler laststatus=0 |
    "         \  autocmd BufLeave <buffer>
    "         \  let &ruler = g:before_fzf_ruler |
    "         \  let &laststatus = g:before_fzf_laststatus |
    "         \  unlet g:before_fzf_ruler g:before_fzf_laststatus
    " augroup END

    " move preview half page-up/down using ctrl-p/n
    " ctrl-b/f useful to move the cursor to the left/right
    " wrap preview content
    let $FZF_DEFAULT_OPTS = "--reverse --bind ctrl-n:preview-half-page-down,ctrl-p:preview-half-page-up --preview-window=wrap,hidden"

    let g:fzf_action = {
          \ 'ctrl-t': 'tab split',
          \ 'ctrl-x': 'split',
          \ 'ctrl-s': 'leftabove vsplit',
          \ 'ctrl-v': 'belowright vsplit'
          \ }

    " Ref: https://github.com/junegunn/fzf.vim/issues/942
    " More Info: `:h fzf-examples`
    " let g:fzf_layout = {
    "       \ 'window': {
    "       \   'width': 1,
    "       \   'height': 0.5,
    "       \   'yoffset': 0,
    "       \   'border': 'bottom'
    "       \ }
    "       \ }

    let g:fzf_layout = {
          \ 'window':
          \   'botright 10new'
          \ }

    " safety measure if ripgrep not installed
    if executable('rg')
      let $FZF_DEFAULT_COMMAND = "rg --hidden --files --no-ignore-vcs --type-not nonsense --type-not font --type-not torrent"

      " exclude filenames when using Rg
      " Ref: https://github.com/junegunn/fzf.vim/issues/714#issuecomment-428802659
      " command! -bang -nargs=* CustomRg
      "       \ call fzf#vim#grep(
      "       \ "rg --column --line-number --no-heading --color=always --smart-case -- " . shellescape(<q-args>),
      "       \ 1,
      "       \ winheight(0) < 40 ? fzf#vim#with_preview(
      "       \ {'options': '--with-nth=1,4.. --delimiter : --nth 2..'},
      "       \ 'hidden', 'ctrl-/') :
      "       \ winwidth(0) < 192 && winnr('$') == 1 ? fzf#vim#with_preview(
      "       \ {'options': '--with-nth=1,4.. --delimiter : --nth 2..'},
      "       \ 'up:50%:hidden', 'ctrl-/') :
      "       \ fzf#vim#with_preview(
      "       \ {'options': '--with-nth=1,4.. --delimiter : --nth 2..'},
      "       \ 'hidden', 'ctrl-/'), <bang>0)

      command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \ "rg --column --line-number --no-heading --color=always --smart-case -- " . shellescape(<q-args>),
            \ 1,
            \ fzf#vim#with_preview(
            \ {'options': '--with-nth=1,4.. --delimiter :'},
            \ 'hidden', 'ctrl-/'), <bang>0)

      " Custom BLines with preview (using ripgrep)
      " Ref: https://github.com/junegunn/fzf.vim/issues/374#issuecomment-724301156
      " command! -bang -nargs=* CustomBLines
      "       \ call fzf#vim#grep(
      "       \ 'rg --with-filename --column --line-number --no-heading --smart-case . ' . fnameescape(expand('%:p')),
      "       \ 1,
      "       \ winheight(0) < 40 ? fzf#vim#with_preview(
      "       \ {'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=2,4.. --tiebreak=index --delimiter : --nth 2..'}, 'hidden', 'ctrl-/') :
      "       \ winwidth(0) < 192 ? fzf#vim#with_preview(
      "       \ {'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=2,4.. --tiebreak=index --delimiter : --nth 2..'}, 'up:50%:hidden', 'ctrl-/') :
      "       \ fzf#vim#with_preview({'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=2,4.. --tiebreak=index --delimiter : --nth 2..'}, 'hidden', 'ctrl-/'))
      " \   fzf#vim#with_preview({'options': '--layout reverse-list  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))
    endif

    " preview at the top when winwidth less than 192
    " and at the right when winheight less than 40
    " command! -bang -nargs=? -complete=dir Files
    "       \ call fzf#vim#files(<q-args>,
    "       \ winheight(0) < 40 ? fzf#vim#with_preview('hidden', 'ctrl-/') :
    "       \ winwidth(0) < 192 && winnr('$') == 1 ? fzf#vim#with_preview('up:50%:hidden', 'ctrl-/') :
    "       \ fzf#vim#with_preview('hidden', 'ctrl-/'), <bang>0)

  endif
endfunction
