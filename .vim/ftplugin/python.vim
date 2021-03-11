setlocal colorcolumn=80
setlocal makeprg=flake8\ %\ \\\|\ egrep\ -v\ 'F401\\\|F841\\\|E501\\\|E402'
hi ColorColumn ctermbg=grey ctermfg=none

iabbrev <buffer> ii import
iabbrev <buffer> iia import as<C-left><left>
iabbrev <buffer> ff from import<C-left><BS>
iabbrev <buffer> dd def ():<C-left><BS>

augroup Make
	autocmd!
	autocmd BufWritePost * silent! make | redraw!
augroup END
