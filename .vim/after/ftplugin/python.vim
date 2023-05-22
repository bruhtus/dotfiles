" setlocal colorcolumn=80

" iabbrev <buffer> ii import
" iabbrev <buffer> iia import as<C-left><left>
" iabbrev <buffer> ff from import<C-left><BS>
" iabbrev <buffer> dd def ():<C-left><BS>
" iabbrev <buffer> cc class ():<C-left><BS>
" iabbrev <buffer> mm if __name__ == '__main__':<CR>
" iabbrev <buffer> f; if:<left>

" augroup make_python
"   autocmd!
"   autocmd BufWritePost *.py
"         \ if expand('%:~:p') !=# '~/.config/qutebrowser/config.py' |
"         \   compiler flake8 |
"         \   silent! make!   |
"         \   redraw!         |
"         \ endif
" augroup END

" ensure that pynvim is installed
" if executable('pynvim')
" 	setlocal omnifunc=python3complete#Complete
" endif
