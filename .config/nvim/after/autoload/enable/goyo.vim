" limelight integration with goyo

function! enable#goyo#enter()
  autocmd! InsertEnter * norm zz
  autocmd! InsertLeave *
  silent! Limelight | setlocal showmode
endfunction

function! enable#goyo#leave()
  autocmd! InsertEnter *
  autocmd! InsertLeave *
  silent! Limelight! | setlocal noshowmode
endfunction
