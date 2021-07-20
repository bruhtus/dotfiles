if has('packages')
	let $MYPACK = has('nvim') ? stdpath('config') . '/after/autoload/pack.vim' : '$HOME/.vim/after/autoload/pack.vim'

	command! PackList    packadd minpac | echo 'Total: ' . len(minpac#getpackages('minpac', '', '', 1)) 'plugin(s)' | echo join(sort(minpac#getpackages('minpac', '', '', 1)), "\n")
	command! PackStartup packadd minpac | echo join(sort(minpac#getpackages('minpac', 'start', '', 1)), "\n")
	command! PackClean   source $MYPACK | call pack#init() | call minpac#clean()
	command! PackUpdate  source $MYPACK | call pack#init() | call minpac#update()
	command! PackInstall source $MYPACK | call pack#init() | call minpac#update(keys(filter(copy(minpac#pluglist), {-> !isdirectory(v:val.dir . '/.git')})))

else
	echo 'Please install vim-plug instead'
endif

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
