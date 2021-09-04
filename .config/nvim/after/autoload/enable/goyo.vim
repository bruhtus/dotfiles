" limelight integration with goyo

function! enable#goyo#enter()
  augroup goyo_insert_mode
    autocmd!
    autocmd InsertEnter * setlocal noignorecase | norm zz
    autocmd InsertLeave * setlocal ignorecase
  augroup END
  let b:modeshow = &showmode
  silent! Limelight | setlocal showmode spell complete+=kspell
endfunction

function! enable#goyo#leave()
  autocmd! goyo_insert_mode
  augroup! goyo_insert_mode
  let &showmode = b:modeshow
  silent! Limelight! | setlocal nospell complete-=kspell
endfunction
