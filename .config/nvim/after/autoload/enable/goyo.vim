" limelight integration with goyo

function! enable#goyo#enter()
  autocmd! InsertEnter * setlocal noignorecase | norm zz
  autocmd! InsertLeave * setlocal ignorecase
  let b:modeshow = &showmode
  silent! Limelight | setlocal showmode spell complete+=kspell
endfunction

function! enable#goyo#leave()
  autocmd! InsertEnter *
  autocmd! InsertLeave *
  let &showmode = b:modeshow
  silent! Limelight! | setlocal nospell complete-=kspell
endfunction
