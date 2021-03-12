" lightline plugin config
" install vim-fugitive plugin too

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \              [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ],
      \              [ 'gitbranch', 'fileencoding' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l/%L%<',
      \ },
      \ 'component_function': {
      \   'fileencoding': 'LightlineFileencoding',
      \   'filetype': 'LightlineFiletype',
      \   'gitbranch': 'LightlineGitbranch',
      \ },
      \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
      \ }

" trim fileencoding and filetype if window width less then 70
function! LightlineFileencoding()
	return winwidth(0) > 70 ? &fileencoding : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineGitbranch()
	return winwidth(0) > 70 ? fugitive#head() : ''
endfunction
