" fzf plugin mappings

" open fzf to search all files in home directory
nnoremap <silent> <leader>f :call enable#fzf('Files ~')<CR>

" open fzf to search all files in current working directory
nnoremap <silent> <leader>i :call enable#fzf('Files')<CR>

" open fzf to search all lines in current buffer
" nnoremap <silent> <leader>u
"       \ :if &ft ==# 'filebeagle' \|\| &ft ==# 'GV' \|\| &ft ==# 'git' <Bar>
"       \   call enable#fzf('BLines') <Bar>
"       \ elseif &modified <Bar>
"       \   call enable#fzf('BLines') <Bar>
"       \ elseif executable('rg') <Bar>
"       \   call enable#fzf('CustomBLines') <Bar>
"       \ else <Bar>
"       \   call enable#fzf('BLines') <Bar>
"       \ endif<CR>
nnoremap <silent> <leader>u :call enable#fzf('BLines')<CR>

" open fzf to search all content in current working directory
if executable('rg')
  nnoremap <silent> <leader>o :call enable#fzf('Rg')<CR>
else
  echo 'Ripgrep is not installed'
endif

" open fzf to search all lines in all opened buffer
" wish there's a preview for `Lines` command (still can't figure out how it
" works)
nnoremap <silent> <leader>h :call enable#fzf('Lines')<CR>

" change current working directory with fzf (still WIP)
" nnoremap <silent> <leader>y :call enable#fzf#init() \| call fzf#run(fzf#wrap({'source': 'fd -aHI -E .git -t d', 'sink': 'lcd'}))<CR>
