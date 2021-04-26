function! pack#init() abort
	try
		packadd minpac
		call minpac#init()
	catch
		if has('nvim')
			exe '!git clone https://github.com/k-takata/minpac.git ' . stdpath('config') . '/pack/minpac/opt/minpac'
		else
			exe '!git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac'
		endif
		packadd minpac
		call minpac#init()
	endtry

	call minpac#add('tpope/vim-surround')
	call minpac#add('wellle/targets.vim')
	call minpac#add('airblade/vim-rooter')
	call minpac#add('tpope/vim-commentary')

	call minpac#add('k-takata/minpac',              { 'type': 'opt' })
	call minpac#add('junegunn/gv.vim',              { 'type': 'opt' })
	call minpac#add('ap/vim-css-color',             { 'type': 'opt' })
	call minpac#add('tpope/vim-eunuch',             { 'type': 'opt' })
	call minpac#add('reedes/vim-pencil',            { 'type': 'opt' })
	call minpac#add('junegunn/goyo.vim',            { 'type': 'opt' })
	call minpac#add('tpope/vim-fugitive',           { 'type': 'opt' })
	call minpac#add('luochen1990/rainbow',          { 'type': 'opt' })
	call minpac#add('tommcdo/vim-exchange',         { 'type': 'opt' })
	call minpac#add('junegunn/limelight.vim',       { 'type': 'opt' })
	call minpac#add('junegunn/vim-easy-align',      { 'type': 'opt' })
	call minpac#add('dstein64/vim-startuptime',     { 'type': 'opt' })
	call minpac#add('AndrewRadev/linediff.vim',     { 'type': 'opt' })
	call minpac#add('tweekmonster/startuptime.vim', { 'type': 'opt' })
	call minpac#add('jeetsukumaran/vim-filebeagle', { 'type': 'opt' })
	call minpac#add('junegunn/fzf.vim',             { 'type': 'opt' })
	call minpac#add('junegunn/fzf',                 { 'type': 'opt', 'do': { -> fzf#install() } })

	if has('nvim-0.5')
		call minpac#add('phaazon/hop.nvim')
	else
		call minpac#add('easymotion/vim-easymotion')
	endif

	" call minpac#add('preservim/tagbar')
	" call minpac#add('kshenoy/vim-signature')
	" call minpac#add('glepnir/dashboard-nvim')
endfunction
