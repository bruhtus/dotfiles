" limelight integration with goyo

function! enable#goyo#enter()
  augroup goyo_insert_mode
    autocmd!
    " autocmd InsertEnter * setlocal noignorecase | norm! zz
    autocmd InsertEnter * setlocal noignorecase
    autocmd InsertLeave * setlocal ignorecase
  augroup END
  " highlight character in screen column 80 or more with error highlight
  2match Error /.\%>80v/
  let b:modeshow = &showmode
  let b:spell = &spell
  setlocal showmode spell complete+=kspell
  try
    if !exists(':Limelight') | packadd limelight.vim | endif
    Limelight
  catch /^Vim\%((\a\+)\)\=:E492/
    echo 'Limelight plugin not installed'
  endtry
endfunction

function! enable#goyo#leave()
  autocmd! goyo_insert_mode
  augroup! goyo_insert_mode
  let &showmode = b:modeshow
  let &spell = b:spell
  unlet b:modeshow b:spell
  setlocal complete-=kspell
  " Ref:
  " https://github.com/junegunn/goyo.vim/pull/195#issuecomment-483080401
  " https://github.com/junegunn/goyo.vim/blob/master/autoload/goyo.vim#L340
  " Note:
  " the syntax highlight for `markdownBold` and `markdownItalic`
  " disappear because goyo tried to re-apply the current user colorscheme
  " which means that those colorscheme might remove the previous syntax
  " highlight (using `hi clear`).
  " Solution:
  " for now reload the syntax highlight using, either the `syntax on` like
  " below, or `let &l:syntax = &l:syntax`.
  if exists('g:syntax_on') | syntax on | endif
  try
    Limelight!
  catch /^Vim\%((\a\+)\)\=:E492/
  endtry
endfunction
