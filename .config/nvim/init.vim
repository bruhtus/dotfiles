call plug#begin(stdpath('data') . '/plugged')
Plug 'vimwiki/vimwiki'
Plug 'junegunn/gv.vim'
Plug 'ap/vim-css-color'
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'wellle/targets.vim'
Plug 'airblade/vim-rooter'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-exchange'
Plug 'kshenoy/vim-signature'
" Plug 'mattn/vim-lsp-settings'
" Plug 'prabirshrestha/vim-lsp'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'tweekmonster/startuptime.vim'
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
