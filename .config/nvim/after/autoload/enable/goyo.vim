" limelight integration with goyo

function! enable#goyo#enter()
  autocmd! InsertEnter * norm zz
  autocmd! InsertLeave *
  silent! Limelight | set showmode
endfunction

function! enable#goyo#leave()
  silent! Limelight! | set noshowmode
endfunction
