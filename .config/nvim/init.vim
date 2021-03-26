call plug#begin(stdpath('data') . '/plugged')
Plug 'vimwiki/vimwiki'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'wellle/targets.vim'
Plug 'airblade/vim-rooter'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
