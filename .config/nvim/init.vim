if has('packages')
	function! PackInit() abort
		try
			packadd minpac
		catch
			if has('nvim')
				exe '!git clone https://github.com/k-takata/minpac.git ' . stdpath('config') . '/pack/minpac/opt/minpac'
			else
				exe '!git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac'
			endif
			packadd minpac
		endtry

		call minpac#init()

		call minpac#add('tpope/vim-surround')
		call minpac#add('tpope/vim-fugitive')
		call minpac#add('wellle/targets.vim')
		call minpac#add('airblade/vim-rooter')
		call minpac#add('tpope/vim-commentary')
		call minpac#add('junegunn/vim-easy-align')
		call minpac#add('jeetsukumaran/vim-filebeagle')
		call minpac#add('junegunn/fzf.vim')
		call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })

		call minpac#add('k-takata/minpac',              { 'type': 'opt' })
		call minpac#add('junegunn/gv.vim',              { 'type': 'opt' })
		call minpac#add('ap/vim-css-color',             { 'type': 'opt' })
		call minpac#add('tpope/vim-eunuch',             { 'type': 'opt' })
		call minpac#add('reedes/vim-pencil',            { 'type': 'opt' })
		call minpac#add('junegunn/goyo.vim',            { 'type': 'opt' })
		call minpac#add('luochen1990/rainbow',          { 'type': 'opt' })
		call minpac#add('tommcdo/vim-exchange',         { 'type': 'opt' })
		call minpac#add('junegunn/limelight.vim',       { 'type': 'opt' })
		call minpac#add('dstein64/vim-startuptime',     { 'type': 'opt' })
		call minpac#add('AndrewRadev/linediff.vim',     { 'type': 'opt' })
		call minpac#add('tweekmonster/startuptime.vim', { 'type': 'opt' })

		if has('nvim-0.5')
			call minpac#add('phaazon/hop.nvim')
		else
			call minpac#add('easymotion/vim-easymotion')
		endif

		" call minpac#add('preservim/tagbar')
		" call minpac#add('kshenoy/vim-signature')
		" call minpac#add('glepnir/dashboard-nvim')
	endfunction

	command! FocusMode packadd vim-pencil | packadd goyo.vim | packadd limelight.vim

	command! EnableLinediff packadd linediff.vim | call enable#linediff()

	command! PackStatus  packadd minpac  | call minpac#status()
	command! PackList    packadd minpac  | echo minpac#getpackages('minpac', '', '', 1)
	command! PackStartup packadd minpac  | echo minpac#getpackages('minpac', 'start', '', 1)
	command! PackClean   source $MYVIMRC | call PackInit() | call minpac#clean()
	command! PackUpdate  source $MYVIMRC | call PackInit() | call minpac#update()
	command! PackInstall source $MYVIMRC | call PackInit() | call minpac#update(keys(filter(copy(minpac#pluglist), {-> !isdirectory(v:val.dir . '/.git')})))

else
	echo 'Please install vim-plug instead'
endif

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
