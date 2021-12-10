" preview markdown with `markdown-preview.nvim`

let maplocalleader = '\'

" Ref: https://github.com/tpope/vim-markdown
let g:markdown_fenced_languages = ['bash=sh', 'sh', 'html', 'python']
let g:markdown_minlines = 69

" \\ to preview markdown
let g:mkdp_refresh_slow = 1
nnoremap <buffer> <silent> <localleader>\
      \ :if !exists('g:loaded_markdown_preview') <Bar>
      \    packadd markdown-preview.nvim <Bar>
      \    let g:loaded_markdown_preview = 1 <Bar>
      \  endif <Bar>
      \ call mkdp#util#toggle_preview()<CR>

" break undo sequence when using `,`, `.`, `ctrl-w`, and `ctrl-u`
inoremap , <C-g>u,
inoremap . .<C-g>u
" inoremap <C-w> <C-g>u<C-w>
" inoremap <C-u> <C-g>u<C-u>

" inspired by $VIMRUNTIME/ftplugin/vim.vim and $VIMRUNTIME/ftplugin/python.vim
" Ref:
" https://github.com/tpope/vim-markdown/blob/ed76403b2e0622bc137df4576275a9fd3720b875/ftplugin/markdown.vim#L30-L32
" Known Issue: still not sure what happen, sometimes the comment in code block
" recognized as the header in markdown if there's a code block in quotation
" (using symbol > at the beginning of line).
nnoremap <buffer> <silent> ]] m':<C-u>call search('\v^\S*(#)', 'W', '', '', "synIDattr(synID(line('.'), 1, 1), 'name') ==# 'markdownCode'")<CR>zz
nnoremap <buffer> <silent> [[ m':<C-u>call search('\v^\S*(#)', 'zbW', '', '', "synIDattr(synID(line('.'), 1, 1), 'name') ==# 'markdownCode'")<CR>zz
nnoremap <buffer> <silent> ][ m':<C-u>call search('\v%$\|\S.*\n+(#)', 'W', '', '', "synIDattr(synID(line('.'), 1, 1), 'name') ==# 'markdownCode'")<CR>zz
nnoremap <buffer> <silent> [] m':<C-u>call search('\v\S.*\n+(#)', 'bW', '', '', "synIDattr(synID(line('.'), 1, 1), 'name') ==# 'markdownCode'")<CR>zz
onoremap <buffer> <silent> ]] :<C-u>call search('\v^\S*(#)', 'W', '', '', "synIDattr(synID(line('.'), 1, 1), 'name') ==# 'markdownCode'")<CR>
onoremap <buffer> <silent> [[ :<C-u>call search('\v^\S*(#)', 'zbW', '', '', "synIDattr(synID(line('.'), 1, 1), 'name') ==# 'markdownCode'")<CR>
