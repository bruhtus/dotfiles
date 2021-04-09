call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/gv.vim'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'wellle/targets.vim'
Plug 'airblade/vim-rooter'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-exchange'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vim-easy-align'
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
if has('nvim-0.5')
	Plug 'phaazon/hop.nvim'
else
	Plug 'easymotion/vim-easymotion'
endif
" Plug 'glepnir/dashboard-nvim'
" Plug 'tweekmonster/startuptime.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
