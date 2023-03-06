" disable built-in plugins
" Ref: https://github.com/rbtnn/vim-gloaded/blob/master/plugin/gloaded.vim

let g:loaded_gzip              = 1 " $VIMRUNTIME/plugin/gzip.vim
let g:loaded_tar               = 1 " $VIMRUNTIME/autoload/tar.vim
let g:loaded_tarPlugin         = 1 " $VIMRUNTIME/plugin/tarPlugin.vim
let g:loaded_zip               = 1 " $VIMRUNTIME/autoload/zip.vim
let g:loaded_zipPlugin         = 1 " $VIMRUNTIME/plugin/zipPlugin.vim
let g:loaded_2html_plugin      = 1 " $VIMRUNTIME/plugin/tohtml.vim
let g:loaded_spellfile_plugin  = 1 " $VIMRUNTIME/plugin/spellfile.vim
let g:loaded_spec              = 1
let g:loaded_sql_completion    = 1 " $VIMRUNTIME/autoload/sqlcomplete.vim
let g:loaded_syntax_completion = 1 " $VIMRUNTIME/autoload/syntaxcomplete.vim
let g:loaded_matchit           = 1
" let g:loaded_matchparen       = 1 " $VIMRUNTIME/plugin/matchparen.vim
let g:vimsyn_embed             = 0 " $VIMRUNTIME/syntax/vim.vim

if has('nvim')
  " disable provider in neovim
  let g:loaded_python_provider  = 0
  let g:loaded_python3_provider = 0
  let g:loaded_ruby_provider    = 0
  let g:loaded_node_provider    = 0
  let g:loaded_perl_provider    = 0
else
  " disable default plugin in vim
  let g:loaded_logiPat         = 1 " $VIMRUNTIME/plugin/logiPat.vim
  let g:loaded_rrhelper         = 1 " $VIMRUNTIME/plugin/rrhelper.vim
  let g:loaded_vimball          = 1 " $VIMRUNTIME/autoload/vimball.vim
  let g:loaded_vimballPlugin    = 1 " $VIMRUNTIME/plugin/vimballPlugin.vim
  let g:loaded_getscript        = 1 " $VIMRUNTIME/autoload/getscript.vim
  let g:loaded_getscriptPlugin  = 1 " $VIMRUNTIME/plugin/getscriptPlugin.vim
endif
