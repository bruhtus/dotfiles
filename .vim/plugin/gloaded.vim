" disable built-in plugins
" Ref: https://github.com/rbtnn/vim-gloaded/blob/master/plugin/gloaded.vim

let g:loaded_gzip             = 1
let g:loaded_tar              = 1
let g:loaded_tarPlugin        = 1
let g:loaded_zip              = 1
let g:loaded_zipPlugin        = 1
let g:loaded_2html_plugin     = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_spec             = 1
let g:loaded_matchit          = 1
let g:loaded_matchparen       = 1

if has('nvim')
  " disable provider in neovim
  let g:loaded_python_provider  = 0
  let g:loaded_python3_provider = 0
  let g:loaded_ruby_provider    = 0
  let g:loaded_node_provider    = 0
  let g:loaded_perl_provider    = 0
else
  " disable default plugin in vim
  let g:loaded_logipat          = 1
  let g:loaded_rrhelper         = 1
  let g:loaded_vimballPlugin    = 1
  let g:loaded_getscriptPlugin  = 1
endif
