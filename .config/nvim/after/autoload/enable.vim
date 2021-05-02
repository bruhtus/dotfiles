function! enable#goyo()
	if !exists(':Goyo')
		try
			packadd vim-pencil | packadd goyo.vim | packadd limelight.vim
			Goyo
		catch
			echo 'Goyo, limelight, and vim-pencil plugin not installed'
		endtry
	else
		Goyo
	endif
endfunction

function! enable#rainbow()
	if !exists(':RainbowToggle')
		try
			let g:rainbow_active = 0
			packadd rainbow
			RainbowToggle
		catch
			echo 'Rainbow plugin not installed'
		endtry
	else
		RainbowToggle
	endif
endfunction

function! enable#linediff()
	try
		packadd linediff.vim
		let g:linediff_buffer_type = 'scratch'
		let g:linediff_first_buffer_command  = 'enew'
		let g:linediff_further_buffer_command = 'new'
	catch
		echo 'Linediff plugin not installed'
	endtry
endfunction

function! enable#fugitive()
	try
		packadd vim-fugitive
		Git
	catch
		echo 'Fugitive plugin not installed or not git repo'
	endtry
endfunction

function! enable#filebeagle()
	if !exists(':FileBeagleBufferDir')
		try
			let g:filebeagle_suppress_keymaps = 1
			packadd vim-filebeagle
			FileBeagleBufferDir
		catch
			echo 'Filebeagle plugin not installed'
		endtry
	else
		FileBeagleBufferDir
	endif
endfunction

function! enable#easyalign()
	try
		packadd vim-easy-align

		" Start interactive EasyAlign in visual mode (e.g. vipgl)
		xmap gl <Plug>(EasyAlign)

		" Start interactive EasyAlign for a motion/text object (e.g. glip)
		nmap gl <Plug>(EasyAlign)
	catch
		echo 'Easy-align plugin not installed'
	endtry
endfunction

function! enable#fzf()
	if !exists(':FZF')
		try
			packadd fzf | packadd fzf.vim

			let $FZF_DEFAULT_COMMAND = "rg --hidden --files --no-ignore-vcs"
			let $FZF_DEFAULT_OPTS    = "--bind ctrl-f:preview-half-page-down,ctrl-b:preview-half-page-up --preview-window=wrap"  " move preview half page-up/down using ctrl-b/f

			let g:fzf_action = {
						\ 'ctrl-t': 'tab split',
						\ 'ctrl-x': 'split',
						\ 'ctrl-s': 'vsplit' }

			" exclude filenames when using Rg
			command! -bang -nargs=* Rg
						\ call fzf#vim#grep(
						\ "rg --column --line-number --no-heading --color=always --smart-case " . shellescape(<q-args>),
						\ 1,
						\ winheight(0) < 40 ? fzf#vim#with_preview(
						\ {'options': '--delimiter : --nth 4..'},
						\ 'hidden', 'ctrl-/') :
						\ winwidth(0) < 192 ? fzf#vim#with_preview(
						\ {'options': '--delimiter : --nth 4..'},
						\ 'up:50%:hidden', 'ctrl-/') :
						\ fzf#vim#with_preview(
						\ {'options': '--delimiter : --nth 4..'},
						\ 'hidden', 'ctrl-/'), <bang>0)

			" preview at the top when winwidth less than 192
			" and at the right when winheight less than 40
			command! -bang -nargs=? -complete=dir Files
						\ call fzf#vim#files(<q-args>,
						\ winheight(0) < 40 ? fzf#vim#with_preview('hidden', 'ctrl-/') :
						\ winwidth(0) < 192 ? fzf#vim#with_preview('up:50%:hidden', 'ctrl-/') :
						\ fzf#vim#with_preview('hidden', 'ctrl-/'), <bang>0)

			" Custom BLines with preview (using ripgrep)
			" reference: https://github.com/junegunn/fzf.vim/issues/374#issuecomment-724301156
			command! -bang -nargs=* CustomBLines
						\ call fzf#vim#grep(
						\ 'rg --with-filename --column --line-number --no-heading --smart-case . ' . fnameescape(expand('%:p')),
						\ 1,
						\ winheight(0) < 40 ? fzf#vim#with_preview(
						\ {'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=4.. --delimiter=":"'}, 'hidden', 'ctrl-/') :
						\ winwidth(0) < 192 ? fzf#vim#with_preview(
						\ {'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=4.. --delimiter=":"'}, 'up:50%:hidden', 'ctrl-/') :
						\ fzf#vim#with_preview({'options': '--layout reverse-list --query ' . shellescape(<q-args>) . ' --with-nth=4.. --delimiter=":"'}, 'hidden', 'ctrl-/'))
						" \   fzf#vim#with_preview({'options': '--layout reverse-list  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))

		catch
			echo 'Fzf plugin not installed'
		endtry
	endif
endfunction
