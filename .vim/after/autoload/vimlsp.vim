function! vimlsp#init() abort
  let s:enabled = 0
  let s:FloatingWindow = vital#lsp#import('VS.Vim.Window.FloatingWindow')
  let s:Buffer = vital#lsp#import('VS.Vim.Buffer')

  " highlight link LspErrorHighlight SpellBad
  " highlight link LspHintHighlight SpellCap
  " highlight link LspErrorText SpellBad

  setlocal omnifunc=lsp#complete
  let g:lsp_diagnostics_signs_enabled = 1
  let g:lsp_diagnostics_signs_delay = 1
  let g:lsp_diagnostics_signs_insert_mode_enabled = 1
  " let g:lsp_diagnostics_float_delay = 1
  let g:lsp_document_code_action_signs_enabled = 0
  let g:lsp_format_sync_timeout = 1000
  let g:lsp_preview_float = 1
  " Note: there's an error E685 when delete with range while there's a
  " diagnostics highlight.
  " Issue: https://github.com/prabirshrestha/vim-lsp/issues/888
  let g:lsp_diagnostics_highlights_enabled = 0
  " let g:lsp_diagnostics_highlights_delay = 1
  " let g:lsp_hover_ui = 'float'

  let g:lsp_diagnostics_signs_priority_map = {
        \ 'LspError': 12,
        \ 'LspWarning': 11,
        \ }

  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <Plug>(lsp-definition)
  " nmap <buffer> gs <plug>(lsp-document-symbol-search)
  " nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  " nmap <buffer> <leader>q <plug>(lsp-references)
  " nmap <buffer> <leader>z <plug>(lsp-implementation)
  " nmap <buffer> <leader>x <plug>(lsp-type-definition)
  " nmap <buffer> <leader>e <plug>(lsp-rename)
  nmap <buffer> K <Plug>(lsp-hover-float)
  nmap <buffer> <leader>q <Plug>(lsp-preview-close)<Plug>(lsp-float-close)

  nnoremap <silent> <buffer> gs :call <SID>diagnostics_float()<CR>
  nmap <silent> <buffer> gy <Plug>(lsp-document-diagnostics)

  inoremap <expr> <buffer> <C-f> lsp#scroll(+4)
  inoremap <expr> <buffer> <C-b> lsp#scroll(-4)
endfunction

" Note:
" becauee there's a limit of character on quickfix list or location list
" window, we can't really use the location list window to show all the
" diagnostics message.
" the diagnostics message will truncated at 1024 character.
" Ref: https://github.com/vim/vim/issues/4780
" Ref:
" https://github.com/prabirshrestha/vim-lsp/issues/1074#issuecomment-942911494
function! s:diagnostics_float() abort
  if !s:enabled
    let s:enabled = 1
    call s:show_float(lsp#internal#diagnostics#under_cursor#get_diagnostic())
    augroup vim_lsp_diagnostics_float
      autocmd!
      autocmd CursorMoved *
            \ call s:hide_float() |
            \ let s:enabled = 0 |
            \ autocmd! vim_lsp_diagnostics_float
    augroup END
  endif
endfunction

function! s:show_float(diagnostic) abort
    let l:doc_win = s:get_doc_win()
    if !empty(a:diagnostic) && has_key(a:diagnostic, 'message')
        " Update contents.
        call deletebufline(l:doc_win.get_bufnr(), 1, '$')
        call setbufline(l:doc_win.get_bufnr(), 1, lsp#utils#_split_by_eol(a:diagnostic['message']))

        " Compute size.
        let l:size = l:doc_win.get_size({
        \   'maxwidth': float2nr(&columns * 0.4),
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
        " When the specified position is not visible
        return []
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
