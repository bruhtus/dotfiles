if has('packages')
	let $MYPACK = has('nvim') ? stdpath('config') . '/after/autoload/pack.vim' : '$HOME/.vim/after/autoload/pack.vim'

	command! PackList    packadd minpac | echo minpac#getpackages('minpac', '', '', 1)
	command! PackStartup packadd minpac | echo minpac#getpackages('minpac', 'start', '', 1)
	command! PackClean   source $MYPACK | call pack#init() | call minpac#clean()
	command! PackUpdate  source $MYPACK | call pack#init() | call minpac#update()
	command! PackInstall source $MYPACK | call pack#init() | call minpac#update(keys(filter(copy(minpac#pluglist), {-> !isdirectory(v:val.dir . '/.git')})))

else
	echo 'Please install vim-plug instead'
endif

" reference: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
