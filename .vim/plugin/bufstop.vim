" buffer management mapping

" nmap <expr> <silent> <leader>n
"       \ len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 6 ?
"       \ ":call enable#fzf('Buffers')<CR>" :
"       \ '<Plug>(Bufstop-preview)'

nmap <silent> <leader>n <Plug>(Bufstop-preview)
