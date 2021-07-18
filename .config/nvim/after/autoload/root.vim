" reference:
" https://github.com/junegunn/dotfiles/blob/057ee47465e43aafbd20f4c8155487ef147e29ea/vimrc#L655-L667
" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file

function! root#toggle()
	if exists('g:root_enabled')
		unlet g:root_enabled
		execute 'lcd %:p:h'
		echo 'Root directory disabled'
	else
		let l:root = systemlist('git rev-parse --show-toplevel')[0]

		if v:shell_error
			echo 'Not in git repo'
		else
			let g:root_enabled = 1
			execute 'lcd ' . l:root
			echo 'Changed directory to: ' . l:root
		endif

		augroup RootWindow
			autocmd!
			autocmd WinLeave,BufLeave * if exists('g:root_enabled') | unlet g:root_enabled | endif
		augroup END
	endif
endfunction
