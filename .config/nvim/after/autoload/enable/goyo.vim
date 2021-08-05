" limelight integration with goyo

function! enable#goyo#enter()
  autocmd! InsertEnter * setlocal noignorecase | norm zz
  autocmd! InsertLeave * setlocal ignorecase
  silent! Limelight | setlocal showmode spell complete+=kspell
endfunction

function! enable#goyo#leave()
  autocmd! InsertEnter *
  autocmd! InsertLeave *
  silent! Limelight! | setlocal noshowmode nospell complete-=kspell
endfunction
