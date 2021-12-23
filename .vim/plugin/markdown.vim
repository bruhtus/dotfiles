" Ref: https://github.com/tpope/vim-markdown
if &filetype ==# 'markdown'
  let g:markdown_fenced_languages = ['bash=sh', 'sh', 'javascript', 'json', 'sql']
  let g:markdown_minlines = 69
endif
