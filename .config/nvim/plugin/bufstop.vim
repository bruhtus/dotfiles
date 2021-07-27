let g:bufstop_history = []
let g:bufstop_name = "--Bufstop--"

let s:frequency_map = {}

" callback for map function
function! s:bufstop_filt(val, bufnr)
  if (a:val == a:bufnr)
    return -1
  endif

  return a:val
endfunction

" add the buffer number to the navigation history for the window
function! s:bufstop_append(bufnr)
    if !exists('w:history_index')
      let w:history_index = 0
      let w:history = []
    " ignore if the newly added buffer is the same as the previous active one
    elseif w:history[w:history_index] == a:bufnr
        return
    else
        let w:history_index += 1
    endif

    " replace the bufnr with -1 if it already exists
    call map(w:history, 's:bufstop_filt(v:val, a:bufnr)')

    let w:history = insert(w:history, a:bufnr, w:history_index)
endfunction

" add the buffer number to the global navigation history
function! s:bufstop_global_append(bufnr)
  if (!buflisted(a:bufnr))
    return
  endif
  call filter(g:bufstop_history, 'v:val != '.a:bufnr)
  call insert(g:bufstop_history, a:bufnr)

  if !has_key(s:frequency_map, a:bufnr)
    let s:frequency_map[a:bufnr] = 1
  else
    let s:frequency_map[a:bufnr] += 1
  endif
endfunction

function s:timeout_fiddle(on_off)
  if a:on_off == 1
    let s:old_timeoutlen = &timeoutlen
    let &timeoutlen = 10
  else
    let &timeoutlen = s:old_timeoutlen
  end
endfunction

augroup Bufstop
  autocmd!
  autocmd BufEnter * :call s:bufstop_append(winbufnr(winnr()))
  autocmd WinEnter * :call s:bufstop_append(winbufnr(winnr()))
  autocmd BufWinEnter * :call s:bufstop_global_append(expand('<abuf>') + 0)
  exe "autocmd BufWinEnter,WinEnter " . g:bufstop_name . " :call s:timeout_fiddle(1)"
  exe "autocmd BufWinLeave,WinLeave " . g:bufstop_name . " :call s:timeout_fiddle(0)"
augroup End
