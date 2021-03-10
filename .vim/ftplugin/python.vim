setlocal colorcolumn=80
setlocal makeprg=$HOME/.vim/ftplugin/flake8-grep\ %
hi ColorColumn ctermbg=grey ctermfg=none

iabbrev <buffer> iii import

" operator-pending mappings
onoremap <buffer> aM /def<CR>
onoremap <buffer> iM ?def<CR>

augroup Make
	autocmd!
	autocmd BufWritePost * silent! make | redraw!
augroup END
