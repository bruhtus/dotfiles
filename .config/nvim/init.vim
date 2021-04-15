call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/gv.vim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'wellle/targets.vim'
Plug 'airblade/vim-rooter'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-exchange'
Plug 'junegunn/vim-easy-align'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf',           { 'do':  { -> fzf#install()  } }
Plug 'reedes/vim-pencil',      { 'for': ['markdown', 'nroff'] }
Plug 'junegunn/goyo.vim',      { 'for': ['markdown', 'nroff'] }
Plug 'junegunn/limelight.vim', { 'for': ['markdown', 'nroff'] }
if has('nvim-0.5')
	Plug 'phaazon/hop.nvim'
else
	Plug 'easymotion/vim-easymotion'
endif
" Plug 'preservim/tagbar'
" Plug 'kshenoy/vim-signature'
" Plug 'glepnir/dashboard-nvim'
" Plug 'dstein64/vim-startuptime'
" Plug 'tweekmonster/startuptime.vim'
call plug#end()

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
