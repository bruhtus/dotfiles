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

" inspired by $VIMRUNTIME/ftplugin/vim.vim and $VIMRUNTIME/ftplugin/python.vim
nnoremap <buffer> <silent> ]] m':<C-u>call search('\v^\S*(#)', 'W')<CR>zz
nnoremap <buffer> <silent> [[ m':<C-u>call search('\v^\S*(#)', 'zbW')<CR>zz
nnoremap <buffer> <silent> ][ m':<C-u>call search('\v%$\|\S.*\n+(#)', 'W')<CR>zz
nnoremap <buffer> <silent> [] m':<C-u>call search('\v\S.*\n+(#)', 'bW')<CR>zz
onoremap <buffer> <silent> ]] :<C-u>call search('\v^\S*(#)', 'W')<CR>
onoremap <buffer> <silent> [[ :<C-u>call search('\v^\S*(#)', 'zbW')<CR>
