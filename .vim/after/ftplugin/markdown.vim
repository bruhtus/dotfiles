" preview markdown with `markdown-preview.nvim`

let maplocalleader = '\'

" \\ to preview markdown
let g:mkdp_refresh_slow = 1
nnoremap <buffer> <silent> <localleader>\
      \ :if !exists('g:loaded_markdown_preview') <Bar>
      \    packadd markdown-preview.nvim <Bar>
      \    let g:loaded_markdown_preview = 1 <Bar>
      \  endif <Bar>
      \ call mkdp#util#toggle_preview()<CR>

" break undo sequence when using `,`, `.`, `ctrl-w`, and `ctrl-u`
inoremap <buffer> , <C-g>u,
inoremap <buffer> . .<C-g>u
" inoremap <C-w> <C-g>u<C-w>
" inoremap <C-u> <C-g>u<C-u>

" Ref: http://www.vimregex.com/#address
" Ref: https://twitter.com/VImTipsDaily/status/1475761064977567754
" yank the content inside markdown code block to clipboard register.
" the downside of this approach is that, we need to place the cursor inside of
" markdown code block.
nnoremap <buffer> <silent> yu :?```?+,/```/-y+<CR>

" inspired by $VIMRUNTIME/ftplugin/vim.vim and $VIMRUNTIME/ftplugin/python.vim
" Ref:
" https://github.com/tpope/vim-markdown/blob/ed76403b2e0622bc137df4576275a9fd3720b875/ftplugin/markdown.vim#L30-L32
" Note: if fanced languange activated, it will use the syntax of the specific
" filetype, like comment on `sh` filetype would be `shComment`.
function! s:markdown_header_movement(reverse, end, operator)
  let l:skip_patterns = "synIDattr(synID(line('.'), 1, 1), 'name') =~#"
        \ . "'\a*Comment" . (a:end ? "'" : "\\|markdownCode'")
  let l:search_options = 'z' . (a:reverse ? 'b' : '') . (a:operator ? 's' : '')
        \ . 'W'
  let l:search_patterns =
        \ a:reverse && a:end ? '\v\S.*\n+(#){2,6}' :
        \ a:end ? '\v%$|\S.*\n+(#){2,6}' :
        \ '\v^\S*(#){1,6}\s+\w'

  return search(l:search_patterns, l:search_options, '', '', l:skip_patterns)
endfunction

nnoremap <buffer> <silent> ]] :<C-u>call <SID>markdown_header_movement(0, 0, 0)<CR>
nnoremap <buffer> <silent> [[ :<C-u>call <SID>markdown_header_movement(1, 0, 0)<CR>
nnoremap <buffer> <silent> ][ :<C-u>call <SID>markdown_header_movement(0, 1, 0)<CR>
nnoremap <buffer> <silent> [] :<C-u>call <SID>markdown_header_movement(1, 1, 0)<CR>
onoremap <buffer> <silent> ]] :<C-u>call <SID>markdown_header_movement(0, 0, 1)<CR>
onoremap <buffer> <silent> [[ :<C-u>call <SID>markdown_header_movement(1, 0, 1)<CR>
