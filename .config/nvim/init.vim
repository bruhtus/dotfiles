if has('packages')
	let $MYPACK = has('nvim') ? stdpath('config') . '/after/autoload/pack.vim' : '$HOME/.vim/after/autoload/pack.vim'

	command! PacList    packadd minpac | echo 'Total: ' . len(minpac#getpackages('minpac', '', '', 1)) . ' plugin(s)' | echo join(sort(minpac#getpackages('minpac', '', '', 1)), "\n")
	command! PacQStart  packadd minpac | echo join(sort(minpac#getpackages('minpac', 'start', '', 1)), "\n")
	command! PacClean   source $MYPACK | call pack#init() | call minpac#clean()
	command! PacSync    source $MYPACK | call pack#init() | call minpac#update()
	command! PacInstall source $MYPACK | call pack#init() | call minpac#update(keys(filter(copy(minpac#pluglist), {-> !isdirectory(v:val.dir . '/.git')})))

else
	echo 'Please install vim-plug instead'
endif

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
