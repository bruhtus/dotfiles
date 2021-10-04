" limelight integration with goyo

function! enable#goyo#enter()
  augroup goyo_insert_mode
    autocmd!
    autocmd InsertEnter * setlocal noignorecase | norm! zz
    autocmd InsertLeave * setlocal ignorecase
  augroup END
  let b:modeshow = &showmode
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
  unlet b:modeshow
  setlocal nospell complete-=kspell
  try
    Limelight!
  catch /^Vim\%((\a\+)\)\=:E492/
  endtry
endfunction
