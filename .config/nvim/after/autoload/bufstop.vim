" source: https://github.com/mihaifm/bufstop
let s:lsoutput = ""
let s:types = ["fullname", "path", "shortname", "indicators"]
let s:local_bufnr = -1
let s:fast_mode = 0
let s:preview_mode = 0
let s:speed_mounted = 0

let g:bufstop_split = "leftabove"
let g:bufstop_dismiss_key = "<Space>"
let g:bufstop_keys = "aszxcfvqwer12345tyuiopbnm67890ABCEFGIJKNOPQRSTUVZ"
let g:bufstop_sorting = "MRU"
let g:bufstop_indicators = 1

let s:keystr = g:bufstop_keys
let s:keys = split(s:keystr, '\zs')

if has("syntax")
  hi def link bufstopKey ModeMsg
  hi def link bufstopName Type
end

" truncate long file names
function! s:truncate(str, numfiles)
  let threshhold = 20
  let threshhold = &columns / a:numfiles

  if strlen(a:str) + 3 >= threshhold
    let retval = strpart(a:str, 0, threshhold - 3)
    return retval
  else
    return a:str
  end
endfunction

" set properties for the s:bufstop_main window
function! s:set_properties()
  setlocal nonumber norelativenumber
  setlocal foldcolumn=0
  setlocal colorcolumn=
  setlocal nofoldenable
  setlocal nocursorline
  setlocal nospell
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal nowrap

  if has("syntax")
    syn match bufstopKey /\v^\s\s(\d|\a|\s)/ contained
    syn match bufstopName /\v^\s\s(\d|\a|\s)\s+.+\s\s/ contains=bufstopKey
  endif
endfunction

" select a buffer from the s:bufstop_main window
function! s:bufstop_select_buffer(k)
  if len(s:allbufs) == 0
    return
  endif

  let delkey = 0

  if (a:k == 'd')
    let delkey = 1
  endif

  let keyno = strridx(s:keystr, a:k)
  let s:bufnr = -1

  let pos = 0
  if (keyno >= 0 && !delkey)
    for b in s:allbufs
      let pos += 1
      if b.key ==# a:k
        let s:bufnr = b.bufno
        break
      endif
    endfor
    " move cursor on the selected line
    exe pos
  else
    let s:bufnr = s:allbufs[line('.')-1].bufno
  endif

  if bufexists(s:bufnr)
    if delkey
      call s:bufstop_delete_buffer(s:bufnr)
    else
      exe "wincmd p"
      exe "silent b" s:bufnr
      if !exists('b:bufstop_winview')
        let b:bufstop_winview = winsaveview()
      endif
      exe "wincmd p"
      if s:fast_mode
        exe "q"
        exe "wincmd p"
      endif
    endif
  endif
endfunction

" delete a buffer without altering the window layout
function! s:bufstop_delete_buffer(bufnr)
  for window in range(1, winnr("$"))
    if winbufnr(window) != a:bufnr
      continue
    endif

    let candidate = s:allbufs[0].bufno
    if len(s:allbufs) > 1 && line('.') == 1
      let candidate = s:allbufs[1].bufno
    endif

    exe window . "wincmd w"
    exe "silent b" candidate
    if !exists('b:bufstop_winview')
      let b:bufstop_winview = winsaveview()
    endif

    " our candidate may still be the buffer we're trying to delete
    if bufnr("%") == a:bufnr
      " load a dummy buffer in the window
      exe "enew"
      setlocal bufhidden=wipe
      setlocal noswapfile
      setlocal buftype=
      setlocal nobuflisted
    endif

    exe "wincmd p"
  endfor

  call remove(s:allbufs, line('.')-1)
  exe "silent bd ".s:bufnr
  setlocal modifiable
  exe "d"
  setlocal nomodifiable
  norm! 0
endfunction

function! s:bufstop_restore_winview()
  bd
  wincmd p
  if exists('b:bufstop_winview')
    call winrestview(b:bufstop_winview)
    unlet b:bufstop_winview
  endif
endfunction

" create mappings for the s:bufstop_main window
function! s:map_keys()
  exe 'nnoremap <buffer> <silent> ' . g:bufstop_dismiss_key . ' :call <SID>bufstop_restore_winview()<CR>'
  nnoremap <buffer> <silent> <cr>             :call <SID>bufstop_select_buffer('cr')<cr>
  nnoremap <buffer> <silent> <2-LeftMouse>    :call <SID>bufstop_select_buffer('cr')<cr>
  nnoremap <buffer> <silent> d                :call <SID>bufstop_select_buffer('d')<cr>

  for buf in s:allbufs
    exe "nnoremap <buffer> <silent> ". buf.key. "   :call <SID>bufstop_select_buffer('" . buf.key . "')<cr>"
  endfor
endfunction

function! s:map_preview_keys()
  nnoremap <buffer> <silent> j               j:call <SID>bufstop_select_buffer('cr')<cr>
  nnoremap <buffer> <silent> k               k:call <SID>bufstop_select_buffer('cr')<cr>
  nnoremap <buffer> <silent> H               H:call <SID>bufstop_select_buffer('cr')<cr>
  nnoremap <buffer> <silent> M               M:call <SID>bufstop_select_buffer('cr')<cr>
  nnoremap <buffer> <silent> L               L:call <SID>bufstop_select_buffer('cr')<cr>
  nnoremap <buffer> <silent> <down>          j:call <SID>bufstop_select_buffer('cr')<cr>
  nnoremap <buffer> <silent> <up>            k:call <SID>bufstop_select_buffer('cr')<cr>
endfunction

function! s:unmap_preview_keys()
  silent! nunmap <buffer> j
  silent! nunmap <buffer> k
  silent! nunmap <buffer> <down>
  silent! nunmap <buffer> <up>
endfunction

function! s:bufstop_get_buffer_info()
  redir => s:lsoutput
  exe "silent ls"
  redir END

  return s:get_buffer_info()
endfunction

" parse buffer list and get relevant info
function! s:get_buffer_info()
  let s:allbufs = []
  let [s:allbufs, allwidths] = [[], {}]

  for n in s:types
    let allwidths[n] = []
  endfor

  let k = 0

  let bu_li = split(s:lsoutput, '\n')

  if g:bufstop_sorting == "MRU"
    call sort(bu_li, "<SID>bufstop_mru_cmp")
  elseif g:bufstop_sorting == "MFU"
    call sort(bu_li, "<SID>bufstop_mfu_cmp")
  endif

  for buf in bu_li
    let bits = split(buf, '"')
    let b = {"attributes": bits[0], "line": substitute(bits[2], '\s*', '', '')}

    let b.path = bits[1]
    let b.fullname = bits[1]
    let pathbits = split(bits[1], '\\\|\/', 1)
    let b.shortname = pathbits[len(pathbits)-1]
    let b.bufno = str2nr(bits[0])
    let b.indicators = substitute(bits[0], '\s*\d\+', '', '')

    if (k < len(s:keys))
      let b.key = s:keys[k]
    else
      let b.key = 'X'
    endif

    let k = k + 1

    call add(s:allbufs, b)

    for n in s:types
      call add(allwidths[n], len(b[n]))
    endfor
  endfor

  let s:allpads = {}

  for n in s:types
    let s:allpads[n] = repeat(' ', max(allwidths[n]))
  endfor

  return s:allbufs
endfunction

" wrapper for s:bufstop_main(), default mode
function! bufstop#open()
  let s:fast_mode = 0
  let s:preview_mode = 0
  let b:bufstop_winview = winsaveview()
  call s:bufstop_main()
  call s:unmap_preview_keys()
endfunction

" wrapper for s:bufstop_main(), fast mode
" function! BufstopFast()
"   let s:fast_mode = 1
"   let s:preview_mode = 0
"   let b:bufstop_winview = winsaveview()
"   call s:bufstop_main()
"   call s:unmap_preview_keys()
" endfunction

" wrapper for s:bufstop_main(), preview mode
function! bufstop#preview()
  let s:fast_mode = 0
  let s:preview_mode = 1
  let b:bufstop_winview = winsaveview()
  call s:bufstop_main()

  call s:map_preview_keys()
endfunction

" main plugin entry point
function! s:bufstop_main()
  let bufstop_winnr = bufwinnr(g:bufstop_name)
  if bufstop_winnr != -1
    exe bufstop_winnr . "wincmd w"
    exe "q"
    return
  endif

  redir => s:lsoutput
  exe "silent ls"
  redir END

  let lines = []
  let bufdata = s:get_buffer_info()

  for buf in bufdata
    let line = ''
    if buf.key ==# 'X'
      let line = "  " . " "
    else
      let line = "  " . buf.key
    endif

    if g:bufstop_indicators
      let pad = s:allpads.indicators
      let line .= buf.indicators . strpart(pad, len(buf.indicators))
    else
      let line .= " "
    endif

    let path = buf["path"]
    let pad = s:allpads.shortname

    " let shortn = fnamemodify(buf.shortname, ":r")
    let line .= buf.shortname . "  " . strpart(pad . path, len(buf.shortname))

    call add(lines, line)
  endfor

  exe g:bufstop_split . " " . min([len(lines), 20]) . " split"

  if s:local_bufnr < 0
    exe "silent e ".g:bufstop_name
    let s:local_bufnr = bufnr(g:bufstop_name)
  else
    exe "b ".s:local_bufnr
  endif

  setlocal modifiable
  exe 'setlocal statusline=Bufstop:\ ' . len(lines) . '\ buffers'
  " delete evertying in the buffer
  " (can't use 'normal ggdG' since the keys are remapped)
  exe 'goto'
  exe '%delete _'
  call setline(1, lines)
  " set cursor on the alternate buffer by default
  if len(lines) > 1 && !s:preview_mode
    exe 2
  endif
  setlocal nomodifiable
  norm! 0gg

  call s:set_properties()

  call s:map_keys()
endfunction

" switch to a buffer in global history or ls output
function! s:bufstop_switch_to(bufidx)
  call filter(g:bufstop_history, "buflisted(v:val)")

  if a:bufidx >= len(g:bufstop_history)
    if !exists("s:allbufs") || a:bufidx >= len(s:allbufs)
      call s:bufstop_echo("outside range")
      return
    else
      exe "b " . s:allbufs[a:bufidx].bufno
    endif
  else
    exe "b " . g:bufstop_history[a:bufidx]
  endif
endfunction

" echo a message in the Vim status line.
function! s:bufstop_echo(msg)
  echohl WarningMsg
  echomsg 'Bufstop: ' . a:msg
  echohl None
endfunction

" MRU compare callback
function! s:bufstop_mru_cmp(line1, line2)
  let i1 = index(g:bufstop_history, str2nr(a:line1))
  let i2 = index(g:bufstop_history, str2nr(a:line2))
  " make sure the buffers that are not in history end up at the bottom
  if i1 == -1
    let i1 = len(g:bufstop_history) + 1
  endif
  if i2 == -1
    let i2 = len(g:bufstop_history) + 1
  endif

  return  i1 - i2
endfunction

" MFU compare callback
" function! s:bufstop_mfu_cmp(line1, line2)
"   let i1 = 0
"   let i2 = 0

"   if has_key(s:frequency_map, str2nr(a:line1))
"     let i1 = s:frequency_map[str2nr(a:line1)]
"   endif
"   if has_key(s:frequency_map, str2nr(a:line2))
"     let i2 = s:frequency_map[str2nr(a:line2)]
"   endif

"   return  i2 - i1
" endfunction
