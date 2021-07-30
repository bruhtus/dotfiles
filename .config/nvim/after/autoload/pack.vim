" vim script variable reference: https://developer.ibm.com/technologies/linux/articles/l-vim-script-1/

let s:packstart = [
			\ ['tpope/vim-sleuth',     {}],
			\ ['tpope/vim-surround',   {}],
			\ ['wellle/targets.vim',   {}],
			\ ['tpope/vim-commentary', {}],
			\ ['andymass/vim-matchup', {}]
			\ ]

let s:packopt = [
			\ ['junegunn/gv.vim',              { 'type': 'opt' }],
			\ ['ap/vim-css-color',             { 'type': 'opt' }],
			\ ['tpope/vim-eunuch',             { 'type': 'opt' }],
			\ ['junegunn/goyo.vim',            { 'type': 'opt' }],
			\ ['tpope/vim-fugitive',           { 'type': 'opt' }],
			\ ['rhysd/committia.vim',          { 'type': 'opt' }],
			\ ['luochen1990/rainbow',          { 'type': 'opt' }],
			\ ['tommcdo/vim-exchange',         { 'type': 'opt' }],
			\ ['junegunn/limelight.vim',       { 'type': 'opt' }],
			\ ['junegunn/vim-easy-align',      { 'type': 'opt' }],
			\ ['dstein64/vim-startuptime',     { 'type': 'opt' }],
			\ ['AndrewRadev/linediff.vim',     { 'type': 'opt' }],
			\ ['ronakg/quickr-preview.vim',    { 'type': 'opt' }],
			\ ['kristijanhusak/vim-packager',  { 'type': 'opt' }],
			\ ['tweekmonster/startuptime.vim', { 'type': 'opt' }],
			\ ['jeetsukumaran/vim-filebeagle', { 'type': 'opt' }],
			\ ['junegunn/fzf',                 { 'type': 'opt' }],
			\ ['junegunn/fzf.vim',             { 'type': 'opt' }],
			\ ['iamcco/markdown-preview.nvim', {
				\ 'type': 'opt',
				\ 'do':   ':call mkdp#util#install()' }]
			\ ]

if has('nvim-0.5')
	call extend(s:packopt, [
				\ ['phaazon/hop.nvim',          { 'type': 'opt' }],
				\ ['neovim/nvim-lspconfig',     { 'type': 'opt' }],
				\ ['kabouzeid/nvim-lspinstall', { 'type': 'opt' }]
				\ ])
else
	call extend(s:packopt, [
				\ ['easymotion/vim-easymotion', { 'type': 'opt' }]
				\ ])
endif

let s:packlist = s:packstart + s:packopt

function! pack#init() abort
	try
		packadd vim-packager
		call packager#init({'window_cmd': 'topleft new'})
	catch
		if has('nvim')
			exe '!git clone https://github.com/kristijanhusak/vim-packager.git ' . stdpath('config') . '/pack/packager/opt/vim-packager'
		else
			exe '!git clone https://github.com/kristijanhusak/vim-packager.git ~/.vim/pack/packager/opt/vim-packager'
		endif
		packadd vim-packager
		call packager#init({'window_cmd': 'topleft new'})
	endtry

	for [pack, option] in s:packlist
		call packager#add(pack, option)
	endfor
endfunction
