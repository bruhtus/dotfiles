" stole this from vim-unimpaired plugin (sorry lord tpope)
function! blank#up(count) abort
	norm m`
	put!=repeat(nr2char(10), a:count)
	norm ``
endfunction

function! blank#down(count) abort
	norm m`
	put =repeat(nr2char(10), a:count)
	norm ``
endfunction
