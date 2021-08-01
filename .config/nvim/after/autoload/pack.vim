function! pack#init() abort
  try
    packadd vim-packager
    call packager#init({'window_cmd': 'topleft new'})
  catch
    if has('nvim')
      exe '!git clone https://github.com/kristijanhusak/vim-packager.git ' . stdpath('config') . '/pack/packager/opt/vim-packager'
    else
      exe '!git clone https://github.com/kristijanhusak/vim-packager.git ~/.vim/pack/packager/opt/vim-packager'
    endif
    packadd vim-packager
    call packager#init({'window_cmd': 'topleft new'})
  endtry

  call packager#add('tpope/vim-sleuth')
  call packager#add('tpope/vim-surround')
  call packager#add('wellle/targets.vim')
  call packager#add('tpope/vim-commentary')
  call packager#add('andymass/vim-matchup')

  call packager#add('junegunn/gv.vim',              { 'type': 'opt' })
  call packager#add('ap/vim-css-color',             { 'type': 'opt' })
  call packager#add('tpope/vim-eunuch',             { 'type': 'opt' })
  call packager#add('junegunn/goyo.vim',            { 'type': 'opt' })
  call packager#add('tpope/vim-fugitive',           { 'type': 'opt' })
  call packager#add('rhysd/committia.vim',          { 'type': 'opt' })
  call packager#add('luochen1990/rainbow',          { 'type': 'opt' })
  call packager#add('tommcdo/vim-exchange',         { 'type': 'opt' })
  call packager#add('junegunn/limelight.vim',       { 'type': 'opt' })
  call packager#add('junegunn/vim-easy-align',      { 'type': 'opt' })
  call packager#add('dstein64/vim-startuptime',     { 'type': 'opt' })
  call packager#add('AndrewRadev/linediff.vim',     { 'type': 'opt' })
  call packager#add('ronakg/quickr-preview.vim',    { 'type': 'opt' })
  call packager#add('kristijanhusak/vim-packager',  { 'type': 'opt' })
  call packager#add('tweekmonster/startuptime.vim', { 'type': 'opt' })
  call packager#add('jeetsukumaran/vim-filebeagle', { 'type': 'opt' })
  call packager#add('junegunn/fzf',                 { 'type': 'opt' })
  call packager#add('junegunn/fzf.vim',             { 'type': 'opt' })
  call packager#add('iamcco/markdown-preview.nvim', { 'type': 'opt', 'do': ':call mkdp#util#install()' })

  if has('nvim-0.5')
    call packager#add('phaazon/hop.nvim',          { 'type': 'opt' })
    call packager#add('neovim/nvim-lspconfig',     { 'type': 'opt' })
    call packager#add('kabouzeid/nvim-lspinstall', { 'type': 'opt' })
  else
    call packager#add('easymotion/vim-easymotion', { 'type': 'opt' })
  endif

  " call packager#add('mihaifm/bufstop')
  " call packager#add('airblade/vim-rooter')
  " call packager#add('preservim/tagbar')
  " call packager#add('kshenoy/vim-signature')
  " call packager#add('glepnir/dashboard-nvim')
endfunction
