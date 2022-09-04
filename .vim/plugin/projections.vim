" we can also make .projections.json in project root,
" that's why i use double quote.
let g:projectionist_heuristics = {
      \   "workspace.json&libs/api/features/" : {
      \     "libs/api/features/**/src/lib/*.data.ts": {
      \       "type": "data",
      \       "alternate": "{file|dirname}/{basename}.data.spec.ts"
      \     },
      \     "libs/api/features/**/src/lib/*.shell.ts": {
      \       "type": "shell",
      \       "alternate": "{file|dirname}/{basename}.shell.spec.ts"
      \     },
      \     "libs/api/features/**/src/lib/*.core.ts": {
      \       "type": "core"
      \     },
      \     "libs/api/features/**/src/lib/*.schema.ts": {
      \       "type": "schema"
      \     },
      \   },
      \   "workspace.json&libs/api/routes/": {
      \     "libs/api/routes/**/src/lib/*.ts": {
      \       "type": "routes",
      \       "alternate": "{file|dirname}/{basename}.spec.ts"
      \     },
      \   },
      \   "workspace.json&libs/api/": {
      \     "libs/api/*/index.ts": {
      \       "type": "index"
      \     },
      \   },
      \   ".git/&package.json": {
      \     "package.json": {
      \       "type": "package"
      \     },
      \   },
      \   "docs/*.dbml": {
      \     "docs/*.dbml": {
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
