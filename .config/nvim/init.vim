set runtimepath^=~/.vim runtimepath+=~/.vim/after
if has('packages') | let &packpath = &runtimepath | endif
source ~/.vim/vimrc
