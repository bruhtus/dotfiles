let mapleader = ' '

if has('packages')
  let $MYPACK = has('nvim') ? stdpath('config') . '/after/autoload/pack.vim' : '$HOME/.vim/after/autoload/pack.vim'

  command! PacClean   source $MYPACK | call pack#init() | call minpac#clean()
  command! PacSync    source $MYPACK | call pack#init() | call minpac#update()
  command! PacMove    source $MYPACK | call pack#init() | call pack#move()

  command! PacList
        \ packadd minpac                                                |
        \ echo 'Total: '
        \ . len(minpac#getpackages('minpac', '', '', 1)) . ' plugin(s)' |
        \ echo join(sort(minpac#getpackages('minpac', '', '', 1)), "\n")

  " Usage: PacQ start or PacQ opt
  " Ref: https://dev.to/dlains/create-your-own-vim-commands-415b
  command! -nargs=1 PacQ
        \ packadd minpac                           |
        \ exe "echo 'Total:'"
        \ . "len(minpac#getpackages('minpac', '"
        \ . <f-args> . "', '', 1)) . ' plugin(s)'" |
        \ exe "echo join(sort(minpac#getpackages('minpac', '"
        \ . <f-args> . "', '', 1)), " . '"\n")'

  command! PacInstall
        \ source $MYPACK   |
        \ call pack#init() |
        \ call minpac#update(
        \ keys(filter(copy(minpac#pluglist), {-> !isdirectory(v:val.dir . '/.git')}))
        \ )

else
  echo 'Please install vim-plug instead'
endif

" Ref: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
