call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/gv.vim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'wellle/targets.vim'
Plug 'airblade/vim-rooter'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-exchange'
Plug 'junegunn/vim-easy-align'
Plug 'dstein64/vim-startuptime'
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
if has('nvim-0.5')
	Plug 'phaazon/hop.nvim'
else
	Plug 'easymotion/vim-easymotion'
endif
" Plug 'kshenoy/vim-signature'
" Plug 'glepnir/dashboard-nvim'
call plug#end()

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
