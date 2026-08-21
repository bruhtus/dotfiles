" trim extra whitespace at the end of line

function! s:trim_trailing_whitespace() abort
  let l:save = winsaveview()
  keepjumps keeppatterns %s/\s\+$//e
  call winrestview(l:save)
  unlet l:save
endfunction

command! TrimWSExec call s:trim_trailing_whitespace()
command! TrimWSOnB let b:trim_trailing_whitespace = 1
command! TrimWSOnG let g:trim_trailing_whitespace = 1
command! TrimWSOffB let b:trim_trailing_whitespace = 0
command! TrimWSOffG let g:trim_trailing_whitespace = 0

augroup no_trailing_whitespace
  autocmd!
  " Note: do not trim whitespace in viminfo file, it's dangerous!
  autocmd BufWritePre *
        \ if get(
        \   b:,
        \   'trim_trailing_whitespace',
        \   get(g:, 'trim_trailing_whitespace', 1)
        \ )
        \ && expand('<afile>') !=# 'viminfo'
        \ && expand('%:p:h') !~# 'linux-kernel' |
        \   call s:trim_trailing_whitespace() |
        \ endif
augroup END
