" for more info :h write-compiler-plugin

" I'm not sure if it did something
" I've already set current_compiler variable before executing this file
" but it still got loaded. Why?
if exists('current_compiler')
  finish
endif
" did it really set the current_compiler variable?
let current_compiler = 'flake8'

" did CompilerSet command a thing? I can't seem to find it on neovim or vim
" 8.2
" 'older Vim always used :setlocal' That's what the pylint.vim in
" $VIMRUNTIME/compiler/pylint.vim said.
if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

" ensure that flake8 is installed
if executable('flake8')
  CompilerSet makeprg=flake8\ %\ \\\|\ grep\ -Ev\ 'F401\\\|F841\\\|E501\\\|E402'
  " Ref: https://stackoverflow.com/a/7757750 (the first comment)
  " Ref: https://stackoverflow.com/a/36959245
  " Ref: :h efm-ignore
  " Known Issue: this put the first quicklist window with all the error and then
  " put the second quickfix window after the filtering. that makes a glitch
  " when using redraw. using egrep is better in this case.
  " CompilerSet errorformat^=%-G%.%#%\\%%(F401%\\\|F841%\\\|E501%\\\|E402%\\)%.%#
endif

" reference if I want to use the default error format
" CompilerSet errorformat&
