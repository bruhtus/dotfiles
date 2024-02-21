" we can also make .projections.json in project root,
" that's why i use double quote.
let g:projectionist_heuristics = {
      \   ".projections.json": {
      \     ".projections.json": {
      \       "type": "project"
      \     },
      \   },
      \   ".git/&package.json": {
      \     "package.json": {
      \       "type": "package"
      \     },
      \   },
      \   "docs/": {
      \     "docs/*.dbml": {
      \       "type": "docs"
      \     },
      \     "docs/*.md": {
      \       "type": "docs"
      \     },
      \     "docs/*.markdown": {
      \       "type": "docs"
      \     },
      \   },
      \   ".git/&readme.md|.git/&README.md|.git/&README.markdown": {
      \     "readme.md": {
      \       "type": "docs"
      \     },
      \     "README.md": {
      \       "type": "docs"
      \     },
      \     "README.markdown": {
      \       "type": "docs"
      \     },
      \   },
      \ }
