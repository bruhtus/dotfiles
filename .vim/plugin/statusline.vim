set statusline=
set statusline+=\ %3{ModeCurrent()}
set statusline+=\ %r
set statusline+=\ |
set statusline+=\ %{StatuslineFilename()}
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %{StatuslineGit()}
set statusline+=\ |
set statusline+=\ %{StatuslineFileencoding()}
set statusline+=\ |
set statusline+=\ %{StatuslineFiletype()}
set statusline+=\ %3l/%L%<

hi StatusLine ctermfg=233 guifg=#121212
hi StatusLineTerm ctermfg=233 guifg=#121212

function! StatuslineFilename()
	" see h expand() to for more info
	" use 'blank' if 'no name' file
	let l:fullpath = (expand('%:~:p') !=# '' ? expand('%:~:p') : '[Blank]')
	let l:relativepath = (expand('%') !=# '' ? expand('%') : '[Blank]')
	if winwidth(0) > 160
		return l:fullpath
	elseif winwidth(0) < 71
		return expand('%:t')
	else
		return pathshorten(l:relativepath, 2)
	endif
endfunction

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	" doesn't give an error if vim-fugitive not installed
	if exists('*FugitiveHead')
		return winwidth(0) > 70 ? fugitive#head() : ''
	else
		return winwidth(0) > 70 ? GitBranch() : ''
	endif
endfunction

function! StatuslineFileencoding()
	return winwidth(0) > 70 ? &fileencoding : ''
endfunction

function! StatuslineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

let g:currentmode={ 'n' : 'N', 'v' : 'V', 'V' : 'VL', '^V' : 'VB', 's' : 'S', 'S': 'SL', '^S' : 'SB', 'i' : 'I', 'R' : 'R', 'c' : 'C', 't' : 'T'}

function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'VB'))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction
