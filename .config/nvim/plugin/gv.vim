" gv.vim plugin config (to check git commit in vim)
function! ManageGitCommit()
	let l:choice = confirm("Current file git commit(s) or All git commit(s)?",
				\	"&JCurrent\n&KAll")

	if l:choice == 1
		GV!
	elseif l:choice == 2
		GV
	endif
endfunction

nnoremap <leader>b :call ManageGitCommit()<CR>
vnoremap <leader>b :GV<CR>
