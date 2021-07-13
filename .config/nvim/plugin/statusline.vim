" statusline config

if has('nvim')
	" do not change statusline of quickfix window
	autocmd! VimEnter,WinEnter,BufWinEnter * if &buftype=='quickfix' | else | call StatuslineLoad('active') | endif
	autocmd! WinLeave * if &buftype=='quickfix' | else | call StatuslineLoad('inactive') | endif

else
	" default setting because can't display filename in the middle statusline
	" in vanilla vim
	set statusline=
	set statusline+=\ %3{StatuslineMode()}
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
	set statusline+=\ |
	set statusline+=\ %3l/%L%<

endif

function! StatuslineLoad(mode)
	if a:mode == 'active'
		setlocal statusline=%!StatuslineComponent()
	else
		setlocal statusline=%!StatuslineNcComponent()
	endif
endfunction

function! StatuslineComponent() abort
	let l:line=''
	let l:line.='  %3{StatuslineMode()}'
	let l:line.='  %{StatuslineGit()}'
	let l:line.='%='
	let l:line.='%r'
	let l:line.=' %{StatuslineFilename()}'
	let l:line.=' %m'
	let l:line.='%='
	let l:line.='%{StatuslineFiletype()}'
	let l:line.='  %3l/%L%<'
	return l:line
endfunction

function! StatuslineNcComponent() abort
	let l:line=''
	let l:line.='%='
	let l:line.='%r'
	let l:line.=' %{StatuslineFilename()}'
	let l:line.=' %m'
	let l:line.='%='
	return l:line
endfunction

function! StatuslineFilename()
	" see :h expand() for more info
	" use 'blank' if 'no name' file
	let l:fullpath = (expand('%:~:p') !=# '' ? expand('%:~:p') : '[Blank]')
	let l:relativepath = (expand('%') !=# '' ? expand('%') : '[Blank]')
	if winwidth(0) > 160
		return l:fullpath
	elseif winwidth(0) < 71
		return expand('%:t')
	else
		return pathshorten(l:relativepath)
	endif
endfunction

function! StatuslineGit()
	" doesn't give an error if vim-fugitive not installed
	if exists('*FugitiveHead')
		return winwidth(0) > 70 ? fugitive#head() : ''
	else
		return winwidth(0) > 70 ? system("git branch --show-current 2>/dev/null | tr -d '\n'") : ''
	endif
endfunction

function! StatuslineFileencoding()
	return winwidth(0) > 70 ? &fileencoding : ''
endfunction

function! StatuslineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! StatuslineMode() abort
	let l:currentmode={
				\ 'n' : 'N',
				\ 'v' : 'V',
				\ 'V' : 'VL',
				\ '^V' : 'VB',
				\ 's' : 'S',
				\ 'S': 'SL',
				\ '^S' : 'SB',
				\ 'i' : 'I',
				\ 'R' : 'R',
				\ 'c' : 'C',
				\ 't' : 'T'}
	let l:modecurrent = mode()
	" use get() -> fails safely, since ^V doesn't seem to register
	" 3rd arg is used when return of mode() == 0, which is case with ^V
	" thus, ^V fails -> returns 0 -> replaced with 'VB'
	let l:modelist = toupper(get(l:currentmode, l:modecurrent, 'VB'))
	let l:current_status_mode = l:modelist
	return l:current_status_mode
endfunction
