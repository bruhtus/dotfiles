" fzf plugin mappings

" open fzf to search all files in home directory
" nnoremap <silent> <leader>f :call enable#fzf('Files ~')<CR>

" open fzf to search all files in current working directory
nnoremap <silent> <leader>i :<C-u>call enable#fzf('Files')<CR>
nnoremap <silent> <leader>I :<C-u>call enable#fzf('Files %:p:h')<CR>

" open fzf to search all lines in current buffer
nnoremap <silent> <leader>u :<C-u>call enable#fzf('BLines')<CR>

" open fzf to search opened buffers
nnoremap <silent> <leader>n :<C-u>call enable#fzf('Buffers')<CR>

" open fzf to search all content in current working directory
nnoremap <expr> <silent> <leader>O
      \ executable('rg') ? ":<C-u>call enable#fzf('Rg')<CR>" :
      \ ":<C-u>echo 'Ripgrep is not installed'<CR>"

" open fzf to search all lines in all opened buffer
" wish there's a preview for `Lines` command (still can't figure out how it
" works)
nnoremap <silent> <leader>U :<C-u>call enable#fzf('Lines')<CR>

" change current working directory with fzf (still WIP)
" TODO:
" https://sean-warman.medium.com/the-quest-for-the-ultimate-vim-file-browser-e0556f9764dc
" https://github.com/junegunn/fzf/issues/1750
" nnoremap <expr> <silent> <leader>f
"       \ executable('fd') ? ':<C-u>call enable#fzf#init() \| '
"       \ . "call fzf#run(fzf#wrap({'source': 'fd -aHI -d 2 -E .git -t d . ~', 'sink': 'lcd'}))<CR>" :
"       \ ":<C-u>echo 'fd is not installed'<CR>"
