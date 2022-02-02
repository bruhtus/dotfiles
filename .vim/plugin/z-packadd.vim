" why the name with prefix `z-`? so that this will be loaded last.
" the loaded order based on the alphabet.
" in case the plugin need settings first before loading the plugin.

" why not put this in `start` directory? so that it's easier to debug.
" everything in the `start` directory will be automatically load, so we need
" to move the plugin directory to `opt` directory (this is the reason why i
" made `PacMove` command).

let s:packlist = [
      \ 'vim-surround',
      \ 'targets.vim',
      \ 'traces.vim',
      \ ]

if &ft !=# 'gitcommit'
  call extend(s:packlist,
        \ [
          \ 'vim-commentary',
          \ 'vim-indentwise',
          \ 'bufstop',
          \ ])
endif

" the flaw when only load in specific filetype is that, let's say we open
" markdown filetype first, the lsp won't be loaded. and then we open
" typescript filetype, we can't really use the lsp because there's a
" limitation on how the vim-lsp-settings (for whatever reason, we can't use
" vim-lsp-settings when not entering vim, with v:vim_did_enter variable).
if &ft !~# '\v(gitcommit|vim|zsh|sh|diff)'
  call extend(s:packlist,
        \ [
          \ 'vim-lsp',
          \ 'vim-lsp-settings',
          \ ])
endif

try
  for s:pack in s:packlist
    exe 'packadd ' . s:pack
  endfor

  command! PacQ
        \ exe "echo 'Total:'"
        \ . len(s:packlist) . "'plugin(s)'" |
        \ echo join(sort(s:packlist), "\n")
catch
endtry
