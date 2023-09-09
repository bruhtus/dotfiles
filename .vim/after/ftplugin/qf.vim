" setlocal nowrap

" Ref:
" https://github.com/ronakg/quickr-preview.vim/issues/20#issuecomment-536802265
function! s:preview() abort
  if &buftype != 'quickfix'
    return
  endif

  let l:index = line('.') - 1

  " check whether current window is location or quickfix list.
  " Ref: https://vi.stackexchange.com/a/18090
  if get(getloclist(0, {'winid':0}), 'winid', 0)
    let l:list = getloclist(0)
  else
    let l:list = getqflist()
  endif

  if len(l:list)
    let l:selected = l:list[l:index]
    exe 'aboveleft pedit +' . l:selected.lnum . ' ' . bufname(l:selected.bufnr)
  endif

  set eventignore+=all
  keepjumps wincmd P
  " make sure the options can be local to window rather than local to buffer
  setlocal nonumber norelativenumber nofoldenable scrolloff=999
  exe 'match Search /\%' . l:selected.lnum . 'l^\s*\zs.\{-}\ze\s*$/'
  keepjumps wincmd p
  set eventignore-=all
endfunction

nmap <buffer> <silent> <nowait> m <C-w>z<CR>zz<C-w>p
nnoremap <buffer> <silent> <nowait> <Space> :<C-u>call <SID>preview()<CR>
" for whatever reason the preview window won't close if qf window already
" closed in vanilla vim
nnoremap <buffer> <silent> i :cclose <Bar> lclose <Bar> pclose <Bar> wincmd p<CR>

" refresh quickfix result
" nnoremap <buffer> <nowait> <expr> <silent> r
"       \ exists('w:quickfix_title') ?
"       \ ':<C-u>exe substitute(w:quickfix_title, "^:", "", "")<CR>' :
"       \ ':<C-u>echo "variable w:quickfix_title does not exist<CR>"'
