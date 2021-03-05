" lightline plugin config

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ],
      \              [ 'percent', 'fileencoding' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l/%L',
      \ },
      \ }
