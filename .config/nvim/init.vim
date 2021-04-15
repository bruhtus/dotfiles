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

		call minpac#add('junegunn/gv.vim')
		call minpac#add('ap/vim-css-color')
		call minpac#add('tpope/vim-eunuch')
		call minpac#add('tpope/vim-surround')
		call minpac#add('tpope/vim-fugitive')
		call minpac#add('wellle/targets.vim')
		call minpac#add('airblade/vim-rooter')
		call minpac#add('luochen1990/rainbow')
		call minpac#add('tpope/vim-commentary')
		call minpac#add('tommcdo/vim-exchange')
		call minpac#add('junegunn/vim-easy-align')
		call minpac#add('jeetsukumaran/vim-filebeagle')
		call minpac#add('junegunn/fzf.vim')
		call minpac#add('junegunn/fzf',           { 'do':   { -> fzf#install() } })

		call minpac#add('k-takata/minpac',              { 'type': 'opt' })
		call minpac#add('reedes/vim-pencil',            { 'type': 'opt' })
		call minpac#add('junegunn/goyo.vim',            { 'type': 'opt' })
		call minpac#add('junegunn/limelight.vim',       { 'type': 'opt' })
		call minpac#add('dstein64/vim-startuptime',     { 'type': 'opt' })
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

	command! PackUpdate call PackInit() | call minpac#update()
	command! PackClean  call PackInit() | call minpac#clean()
	command! PackStatus packadd minpac  | call minpac#status()
	command! PackList   packadd minpac  | echo minpac#getpackages('minpac', 'start', '', 1)
else
	echo 'Please install vim-plug instead'
endif

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
