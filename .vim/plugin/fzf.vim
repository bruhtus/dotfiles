" fzf plugin mappings

" open fzf to search all files in home directory
" nnoremap <silent> <leader>f :call enable#fzf('Files ~')<CR>

" open fzf to search all files in current working directory
nnoremap <silent> <leader>i :call enable#fzf('Files')<CR>
nnoremap <silent> <leader>I :call root#temp() <Bar> call enable#fzf('Files')<CR>

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
nnoremap <expr> <silent> <leader>o
      \ executable('rg') ? ":call enable#fzf('CustomRg')<CR>" :
      \ ":echo 'Ripgrep is not installed'<CR>"

nnoremap <expr> <silent> <leader>O
      \ executable('rg') ? ":call root#temp() <Bar> call enable#fzf('Rg')<CR>" :
      \ ":echo 'Ripgrep is not installed'<CR>"

" open fzf to search all lines in all opened buffer
" wish there's a preview for `Lines` command (still can't figure out how it
" works)
nnoremap <silent> <leader>h :call enable#fzf('Lines')<CR>

" change current working directory with fzf (still WIP)
" TODO:
" https://sean-warman.medium.com/the-quest-for-the-ultimate-vim-file-browser-e0556f9764dc
" https://github.com/junegunn/fzf/issues/1750
nnoremap <expr> <silent> <leader>f
      \ executable('fd') ? ':call enable#fzf#init() \| '
      \ . "call fzf#run(fzf#wrap({'source': 'fd -aHI -d 2 -E .git -t d . ~', 'sink': 'lcd'}))<CR>" :
      \ ":echo 'fd is not installed'<CR>"
