setlocal colorcolumn=80

" ensure that flake8 is installed
if executable('flake8')
	setlocal makeprg=flake8\ %\ \\\|\ egrep\ -v\ 'F401\\\|F841\\\|E501\\\|E402'
endif

" ensure that pynvim is installed
if executable('pynvim')
	setlocal omnifunc=python3complete#Complete
endif

hi ColorColumn ctermbg=grey ctermfg=none

iabbrev <buffer> ii import
iabbrev <buffer> iia import as<C-left><left>
iabbrev <buffer> ff from import<C-left><BS>
iabbrev <buffer> dd def ():<C-left><BS>
iabbrev <buffer> cc class ():<C-left><BS>
iabbrev <buffer> mm if __name__ == '__main__':<CR>
iabbrev <buffer> f; if:<left>

augroup Make
	autocmd!
	autocmd BufWritePost * silent! make | redraw!
augroup END
