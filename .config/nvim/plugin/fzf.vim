" fzf plugin config and mappings

let $FZF_DEFAULT_COMMAND = "rg --hidden --files --no-ignore-vcs"
let $FZF_DEFAULT_OPTS    = "--bind ctrl-f:preview-half-page-down,ctrl-b:preview-half-page-up"  " move preview half page-up/down using ctrl-b/f

let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-s': 'vsplit' }

" open fzf to search all files in home directory
nnoremap <leader>f :Files ~<CR>

" open fzf to search all files in current working directory
nnoremap <leader>i :Files<CR>

" open fzf to search all lines in current buffer
nnoremap <leader>u :BLines<CR>

" open fzf to search all content in current working directory
nnoremap <leader>o :Rg<CR>

" exclude filenames when using Rg
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\ "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
			\ 1,
			\ fzf#vim#with_preview(
			\ {'options': '--delimiter : --nth 4..'},
			\ 'up:50%:hidden', 'ctrl-/'), <bang>0)

" preview at the top when winwidth less than 192
" and at the right when winheight less than 40
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>,
			\ winheight(0) < 40 ? fzf#vim#with_preview('hidden', 'ctrl-/') :
			\ winwidth(0) < 192 ? fzf#vim#with_preview('up:50%:hidden', 'ctrl-/') :
			\ fzf#vim#with_preview('hidden', 'ctrl-/'), <bang>0)
