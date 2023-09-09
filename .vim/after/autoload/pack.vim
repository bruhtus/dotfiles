function! pack#init() abort
  try
    if !exists('g:loaded_minpac') | packadd minpac | endif
    call minpac#init()
  catch /^Vim\%((\a\+)\)\=:E117/
    if has('nvim')
      exe '!git clone https://github.com/k-takata/minpac.git ' . stdpath('config') . '/pack/minpac/opt/minpac'
    else
      silent! exe '!git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac'
      redraw!
    endif
    if !exists('g:loaded_minpac') | packadd minpac | endif
    call minpac#init()
  endtry

  call minpac#add('jidn/vim-dbml',                        { 'type': 'opt' })
  call minpac#add('tkhren/vim-fake',                      { 'type': 'opt' })
  call minpac#add('tpope/vim-dadbod',                     { 'type': 'opt' })
  call minpac#add('chrisbra/vim_faq',                     { 'type': 'opt' })
  call minpac#add('tpope/vim-surround',                   { 'type': 'opt' })
  call minpac#add('tpope/vim-commentary',                 { 'type': 'opt' })
  call minpac#add('tpope/vim-projectionist',              { 'type': 'opt' })
  call minpac#add('kristijanhusak/vim-dadbod-completion', { 'type': 'opt' })

  call minpac#add('sbdchd/neoformat',       { 'type': 'opt' })
  call minpac#add('mattn/vim-lsp-settings', { 'type': 'opt' })
  call minpac#add('prabirshrestha/vim-lsp', { 'type': 'opt' })

  call minpac#add('bruhtus/vim-sneak',        { 'type': 'opt', 'branch': 'personal' })

  call minpac#add('junegunn/fzf',                 { 'type': 'opt' })
  call minpac#add('junegunn/fzf.vim',             { 'type': 'opt' })

  call minpac#add('k-takata/minpac',              { 'type': 'opt' })
  call minpac#add('mbbill/undotree',              { 'type': 'opt' })
  call minpac#add('ap/vim-css-color',             { 'type': 'opt' })
  call minpac#add('tpope/vim-eunuch',             { 'type': 'opt' })
  call minpac#add('junegunn/goyo.vim',            { 'type': 'opt' })
  call minpac#add('tpope/vim-fugitive',           { 'type': 'opt' })
  call minpac#add('tommcdo/vim-exchange',         { 'type': 'opt' })
  call minpac#add('junegunn/limelight.vim',       { 'type': 'opt' })
  call minpac#add('junegunn/vim-easy-align',      { 'type': 'opt' })
  call minpac#add('dstein64/vim-startuptime',     { 'type': 'opt' })
  call minpac#add('AndrewRadev/linediff.vim',     { 'type': 'opt' })
  call minpac#add('tweekmonster/helpful.vim',     { 'type': 'opt' })
  call minpac#add('tweekmonster/startuptime.vim', { 'type': 'opt' })
  call minpac#add('jeetsukumaran/vim-filebeagle', { 'type': 'opt' })
  call minpac#add('iamcco/markdown-preview.nvim', { 'type': 'opt',
        \ 'do': 'packadd markdown-preview.nvim | call mkdp#util#install()' })

  " call minpac#add('bruhtus/gv.vim',           { 'type': 'opt', 'branch': 'personal' })
  " call minpac#add('bruhtus/vim-bufstop',      { 'type': 'opt', 'branch': 'personal' })

  " if has('nvim-0.5')
  "   call minpac#add('neovim/nvim-lspconfig',     { 'type': 'opt' })
  "   call minpac#add('kabouzeid/nvim-lspinstall', { 'type': 'opt' })
  " endif

  " call minpac#add('bfrg/vim-qf-preview',       { 'type': 'opt' })
  " call minpac#add('ronakg/quickr-preview.vim', { 'type': 'opt' })

  " call minpac#add('mihaifm/bufstop',              { 'type': 'opt' })
  " call minpac#add('junegunn/gv.vim',              { 'type': 'opt' })
  " call minpac#add('tpope/vim-sleuth',             { 'type': 'opt' })
  " call minpac#add('phaazon/hop.nvim',             { 'type': 'opt' })
  " call minpac#add('preservim/tagbar',             { 'type': 'opt' })
  " call minpac#add('thinca/vim-themis',            { 'type': 'opt' })
  " call minpac#add('justinmk/vim-sneak',           { 'type': 'opt' })
  " call minpac#add('wellle/targets.vim',           { 'type': 'opt' })
  " call minpac#add('markonm/traces.vim',           { 'type': 'opt' })
  " call minpac#add('rhysd/committia.vim',          { 'type': 'opt' })
  " call minpac#add('airblade/vim-rooter',          { 'type': 'opt' })
  " call minpac#add('luochen1990/rainbow',          { 'type': 'opt' })
  " call minpac#add('tpope/vim-scriptease',         { 'type': 'opt' })
  " call minpac#add('andymass/vim-matchup',         { 'type': 'opt' })
  " call minpac#add('kshenoy/vim-signature',        { 'type': 'opt' })
  " call minpac#add('glepnir/dashboard-nvim',       { 'type': 'opt' })
  " call minpac#add('easymotion/vim-easymotion',    { 'type': 'opt' })
  " call minpac#add('jessekelighine/vindent.vim',   { 'type': 'opt' })
  " call minpac#add('jeetsukumaran/vim-indentwise', { 'type': 'opt' })
  " call minpac#add('Konfekt/vim-sentence-chopper', { 'type': 'opt' })
  " call minpac#add('bruhtus/textobj-word-column.vim', { 'type': 'opt', 'branch': 'personal' })
endfunction

" Ref: minpac/autoload/minpac/impl.vim
" Check whether the type was changed. If it was changed, rename the directory.
function! s:prepare_plugin_dir(pluginfo) abort
  let l:dir = a:pluginfo.dir
  if !isdirectory(l:dir)
    if a:pluginfo.type ==# 'start'
      let l:dirtmp = substitute(l:dir, '/start/\ze[^/]\+$', '/opt/', '')
    else
      let l:dirtmp = substitute(l:dir, '/opt/\ze[^/]\+$', '/start/', '')
    endif
    if isdirectory(l:dirtmp)
      " The type was changed (start <-> opt).
      call rename(l:dirtmp, l:dir)
    endif
  endif
endfunction

function! pack#move() abort
  let l:names = keys(g:minpac#pluglist)
  for l:name in l:names
    let l:pluginfo = g:minpac#pluglist[l:name]
    call s:prepare_plugin_dir(l:pluginfo)
  endfor
endfunction
