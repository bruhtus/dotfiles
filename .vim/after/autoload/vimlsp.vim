function! vimlsp#init() abort
  " highlight link LspErrorHighlight SpellBad
  " highlight link LspHintHighlight SpellCap
  " highlight link LspErrorText SpellBad

  setlocal omnifunc=lsp#complete signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  let g:lsp_diagnostics_signs_enabled = 1
  let g:lsp_diagnostics_signs_delay = 1
  let g:lsp_diagnostics_signs_insert_mode_enabled = 1
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

  " nmap <buffer> <C-]> <Plug>(lsp-definition)
  nmap <buffer> K <Plug>(lsp-hover-float)
  nmap <buffer> <F12> <Plug>(lsp-preview-close)<Plug>(lsp-float-close)

  nnoremap <silent> <buffer> <leader>e :<C-u>call <SID>diagnostics_float()<CR>
  nmap <silent> <buffer> gy <Plug>(lsp-document-diagnostics)
  nnoremap <silent> <buffer> gY :<C-u>LspDocumentDiagnostics --buffers=*<CR>
  nmap <silent> <buffer> gz <Plug>(lsp-references)

  " if has('patch-8.2.1978')
  "   inoremap <buffer> <C-j> <Cmd>call
  "         \ lsp#ui#vim#signature_help#get_signature_help_under_cursor()<CR>
  " else
    imap <buffer> <C-j> <C-\><C-o><Plug>(lsp-signature-help)
  " endif

  nnoremap <expr> <buffer> ]- lsp#scroll(+1)
  nnoremap <expr> <buffer> [- lsp#scroll(-1)
  " inoremap <expr> <buffer> <C-f> lsp#scroll(+4)
  " inoremap <expr> <buffer> <C-b> lsp#scroll(-4)
endfunction

" Note:
" because there's a limit of character on quickfix list or location list
" window, we can't really use the location list window to show all the
" diagnostics message.
" the diagnostics message will truncated at 1024 character.
" Ref:
" https://github.com/vim/vim/issues/4780
" https://github.com/prabirshrestha/vim-lsp/issues/1074#issuecomment-942911494
function! s:diagnostics_float() abort
  let s:Diagnostic = call(
        \ 'lsp#internal#diagnostics#under_cursor#get_diagnostic',
        \ []
        \ )

  try
    call s:show_float(s:Diagnostic)
  catch /^Vim\%((\a\+)\)\=:E684/
    redraw
    call s:show_float(s:Diagnostic)
  endtry
endfunction

function! s:show_float(diagnostic) abort
  if !empty(a:diagnostic) && has_key(a:diagnostic, 'message')
    let l:lines = split(a:diagnostic['message'], '\n', 1)
    call lsp#ui#vim#output#preview('', l:lines, {
          \   'statusline': ' LSP Diagnostics'
          \})
    let s:displaying_message = 1
  elseif get(s:, 'displaying_message', 0)
    call lsp#ui#vim#output#closepreview()
    let s:displaying_message = 0
  endif
endfunction
