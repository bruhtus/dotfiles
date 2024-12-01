let s:FloatingWindow = vital#lsp#import('VS.Vim.Window.FloatingWindow')
let s:Buffer = vital#lsp#import('VS.Vim.Buffer')

function! vimlsp#init() abort
  " highlight link LspErrorHighlight SpellBad
  " highlight link LspHintHighlight SpellCap
  " highlight link LspErrorText SpellBad

  setlocal omnifunc=lsp#complete signcolumn=yes
  " if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  let g:lsp_diagnostics_signs_enabled = 1
  let g:lsp_diagnostics_signs_delay = 1
  let g:lsp_diagnostics_signs_insert_mode_enabled = 1
  let g:lsp_format_sync_timeout = 1000
  let g:lsp_preview_float = 1
  " let g:lsp_diagnostics_highlights_delay = 1
  " let g:lsp_hover_ui = 'float'

  let g:lsp_diagnostics_signs_priority_map = {
        \ 'LspError': 12,
        \ 'LspWarning': 11,
        \ }

  nmap <buffer> cr <Plug>(lsp-rename)
  nmap <buffer> gb <Plug>(lsp-definition)
  nmap <buffer> K <Plug>(lsp-hover-float)
  nmap <buffer> <F12> <Plug>(lsp-preview-close)<Plug>(lsp-float-close)

  nnoremap <silent> <buffer> <leader>e :<C-u>call <SID>diagnostics_float()<CR>
  nmap <silent> <buffer> gy <Plug>(lsp-document-diagnostics)
  nnoremap <silent> <buffer> gY :<C-u>LspDocumentDiagnostics --buffers=*<CR>
  nmap <silent> <buffer> gz <Plug>(lsp-references)
  nmap <silent> <buffer> g. <Plug>(lsp-document-symbol)
  nmap <silent> <buffer> <C-w><C-e> m':<C-u>LspNextDiagnostic<CR>
  nmap <silent> <buffer> <C-w><C-y> m':<C-u>LspPreviousDiagnostic<CR>

  " if has('patch-8.2.1978')
  "   inoremap <buffer> <C-j> <Cmd>call
  "         \ lsp#ui#vim#signature_help#get_signature_help_under_cursor()<CR>
  " else
    imap <buffer> <C-j> <C-\><C-o><Plug>(lsp-signature-help)
  " endif

  nnoremap <expr> <buffer> <Down> lsp#scroll(+1)
  nnoremap <expr> <buffer> <Up> lsp#scroll(-1)
  inoremap <expr> <buffer> <Down> lsp#scroll(+1)
  inoremap <expr> <buffer> <Up> lsp#scroll(-1)
endfunction

" Note:
" because there's a limit of character on quickfix list or location list
" window, we can't really use the location list window to show all the
" diagnostics message.
" the diagnostics message will truncated at 1024 character.
" Ref:
" - https://github.com/vim/vim/issues/4780
" - https://github.com/prabirshrestha/vim-lsp/issues/1074#issuecomment-942911494
" - https://github.com/saccarosium/vim-lsp/commit/1ff19fdcb1e3c8ae9db76808542f8e67c81840cb
function! s:diagnostics_float() abort
  let l:diagnostic = lsp#internal#diagnostics#under_cursor#get_diagnostic()
  if empty(l:diagnostic) | return | endif
  call s:show_float(l:diagnostic)
  call timer_start(0, {-> execute("au CursorMoved,InsertEnter * ++once :call s:hide_float()")})
endfunction

function! s:show_float(diagnostic) abort
  let l:doc_win = s:get_doc_win()
  if !empty(a:diagnostic) && has_key(a:diagnostic, 'message')
    " Update contents.
    silent call deletebufline(l:doc_win.get_bufnr(), 1, '$')
    call setbufline(l:doc_win.get_bufnr(), 1, lsp#utils#_split_by_eol(a:diagnostic['message']))

    " Compute size.
    if g:lsp_float_max_width >= 1
      let l:maxwidth = g:lsp_float_max_width
    elseif g:lsp_float_max_width == 0
      let l:maxwidth = &columns
    else
      let l:maxwidth = float2nr(&columns * 0.4)
    endif
    let l:size = l:doc_win.get_size({
    \   'maxwidth': l:maxwidth,
    \   'maxheight': float2nr(&lines * 0.4),
    \ })

    " Compute position.
    let l:pos = s:compute_position(l:size)

    " Open window.
    call l:doc_win.open({
    \   'row': l:pos[0],
    \   'col': l:pos[1],
    \   'width': l:size.width,
    \   'height': l:size.height,
    \   'border': v:true,
    \   'topline': 1,
    \ })
  else
    call s:hide_float()
  endif
endfunction

function! s:hide_float() abort
  let l:doc_win = s:get_doc_win()
  call l:doc_win.close()
endfunction

function! s:get_doc_win() abort
  if exists('s:doc_win')
    return s:doc_win
  endif

  let s:doc_win = s:FloatingWindow.new({
  \   'on_opened': { -> execute('doautocmd <nomodeline> User lsp_float_opened') },
  \   'on_closed': { -> execute('doautocmd <nomodeline> User lsp_float_closed') }
  \ })
  call s:doc_win.set_var('&wrap', 1)
  call s:doc_win.set_var('&conceallevel', 2)
  noautocmd silent let l:bufnr = s:Buffer.create()
  call s:doc_win.set_bufnr(l:bufnr)
  call setbufvar(s:doc_win.get_bufnr(), '&buftype', 'nofile')
  call setbufvar(s:doc_win.get_bufnr(), '&bufhidden', 'hide')
  call setbufvar(s:doc_win.get_bufnr(), '&buflisted', 0)
  call setbufvar(s:doc_win.get_bufnr(), '&swapfile', 0)
  return s:doc_win
endfunction

function! s:compute_position(size) abort
  let l:pos = screenpos(0, line('.'), col('.'))
  if l:pos.row == 0 && l:pos.col == 0
    let l:pos = {'curscol': screencol(), 'row': screenrow()}
  endif
  let l:pos = [l:pos.row + 1, l:pos.curscol + 1]
  if l:pos[0] + a:size.height > &lines
    let l:pos[0] = l:pos[0] - a:size.height - 3
  endif
  if l:pos[1] + a:size.width > &columns
    let l:pos[1] = l:pos[1] - a:size.width - 3
  endif
  return l:pos
endfunction
