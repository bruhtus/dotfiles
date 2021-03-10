setlocal colorcolumn=80
setlocal makeprg=flake8\ %\ \\\|\ egrep\ -v\ 'F401\\\|F841\\\|E501\\\|E402'
hi ColorColumn ctermbg=grey ctermfg=none

iabbrev <buffer> iii import

" operator-pending mappings
onoremap <buffer> aM /def<CR>
onoremap <buffer> iM ?def<CR>

augroup Make
	autocmd!
	autocmd BufWritePost * silent! make | redraw!
augroup END
