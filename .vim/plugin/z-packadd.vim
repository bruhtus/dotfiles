if exists(':packadd') != 2 | finish | endif

" why the name with prefix `z-`? so that this will be loaded last.
" the loaded order based on the alphabet.
" in case the plugin need settings first before loading the plugin.

" why not put this in `start` directory? so that it's easier to debug.
" everything in the `start` directory will be automatically load, so we need
" to move the plugin directory to `opt` directory (this is the reason why i
" made `PacMove` command).

let s:pack = ''

" let s:pack .= 'matchit,'
let s:pack .= 'vim-surround,'
let s:pack .= 'targets.vim,'
let s:pack .= 'traces.vim,'

if &ft !=# 'gitcommit'
  let s:pack .= 'vim-commentary,'
  let s:pack .= 'vim-indentwise,'
  let s:pack .= 'bufstop,'
endif

" the flaw when only load in specific filetype is that, let's say we open
" markdown filetype first, the lsp won't be loaded. and then we open
" typescript filetype, we can't really use the lsp because there's a
" limitation on how the vim-lsp-settings (for whatever reason, we can't use
" vim-lsp-settings when not entering vim, with v:vim_did_enter variable).
if &ft !~# '\v(gitcommit|vim|zsh|sh|diff)' && !&diff
  let s:pack .= 'vim-lsp,'
  let s:pack .= 'vim-lsp-settings,'
  let s:pack .= 'neoformat,'
endif

let s:packlist = split(s:pack, ',')

for s:load in s:packlist
  exe 'packadd ' . s:load
endfor

unlet! s:pack s:load

command! PacQ
      \ exe "echo 'Total:'"
      \ . len(s:packlist) . "'plugin(s)'" |
      \ echo join(sort(s:packlist), "\n")
