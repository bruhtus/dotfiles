if has('packages')
	let $MYPACK = has('nvim') ? stdpath('config') . '/after/autoload/pack.vim' : '$HOME/.vim/after/autoload/pack.vim'

	command! -bar PacList             source $MYPACK | call pack#init() | call packager#status()
	command! -bar PacClean            source $MYPACK | call pack#init() | call packager#clean()
	command! -nargs=* -bar PacInstall source $MYPACK | call pack#init() | call packager#install(<args>)
	command! -nargs=* -bar PacSync    source $MYPACK | call pack#init() | call packager#clean() | call packager#update(<args>)

else
	echo 'Please install vim-plug instead'
endif

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
