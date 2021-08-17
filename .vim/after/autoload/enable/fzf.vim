function! enable#fzf#init()
  if !exists('g:loaded_fzf_vim')
    packadd fzf | packadd fzf.vim

    if !has('nvim')
      autocmd! FileType fzf
            \ let b:laststatus = &laststatus  |
            \ let b:ruler = &ruler            |
            \ set laststatus=0 noruler
            \| autocmd BufLeave <buffer>
            \  let &laststatus = b:laststatus |
            \  let &ruler = b:ruler           |
            \  unlet b:laststatus b:ruler
    endif

    let $FZF_DEFAULT_COMMAND = "rg --hidden --files --no-ignore-vcs --type-not nonsense --type-not font --type-not torrent"

    " move preview half page-up/down using ctrl-b/f
    " wrap preview content
    let $FZF_DEFAULT_OPTS    = "--bind ctrl-f:preview-half-page-down,ctrl-b:preview-half-page-up --preview-window=wrap"

    let g:fzf_action = {
          \ 'ctrl-t': 'tab split',
          \ 'ctrl-x': 'split',
          \ 'ctrl-s': 'vsplit' }

    " exclude filenames when using Rg
    command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \ "rg --column --line-number --no-heading --color=always --smart-case " . shellescape(<q-args>),
          \ 1,
          \ winheight(0) < 40 ? fzf#vim#with_preview(
          \ {'options': '--delimiter : --nth 4..'},
          \ 'hidden', 'ctrl-/') :
          \ winwidth(0) < 192 ? fzf#vim#with_preview(
          \ {'options': '--delimiter : --nth 4..'},
          \ 'up:50%:hidden', 'ctrl-/') :
          \ fzf#vim#with_preview(
          \ {'options': '--delimiter : --nth 4..'},
          \ 'hidden', 'ctrl-/'), <bang>0)

    " preview at the top when winwidth less than 192
    " and at the right when winheight less than 40
    command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>,
          \ winheight(0) < 40 ? fzf#vim#with_preview('hidden', 'ctrl-/') :
          \ winwidth(0) < 192 ? fzf#vim#with_preview('up:50%:hidden', 'ctrl-/') :
          \ fzf#vim#with_preview('hidden', 'ctrl-/'), <bang>0)

    " Custom BLines with preview (using ripgrep)
    " Ref: https://github.com/junegunn/fzf.vim/issues/374#issuecomment-724301156
    command! -bang -nargs=* CustomBLines
          \ call fzf#vim#grep(
          \ 'rg --with-filename --column --line-number --no-heading --smart-case . ' . fnameescape(expand('%:p')),
          \ 1,
          \ winheight(0) < 40 ? fzf#vim#with_preview(
          \ {'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=4.. --delimiter=":"'}, 'hidden', 'ctrl-/') :
          \ winwidth(0) < 192 ? fzf#vim#with_preview(
          \ {'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=4.. --delimiter=":"'}, 'up:50%:hidden', 'ctrl-/') :
          \ fzf#vim#with_preview({'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=4.. --delimiter=":"'}, 'hidden', 'ctrl-/'))
    " \   fzf#vim#with_preview({'options': '--layout reverse-list  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))
  endif
endfunction
