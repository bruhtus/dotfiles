" limelight integration with goyo

function! enable#goyo#enter()
  augroup GoyoEnter
    autocmd!
    autocmd InsertEnter * norm zz
    autocmd InsertLeave *
  augroup END
  silent! Limelight | setlocal showmode
endfunction

function! enable#goyo#leave()
  silent! Limelight! | set noshowmode
endfunction
