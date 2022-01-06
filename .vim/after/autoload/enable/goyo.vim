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
  try
    Limelight!
  catch /^Vim\%((\a\+)\)\=:E492/
  endtry
endfunction
