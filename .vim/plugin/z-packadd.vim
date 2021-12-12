" why the name with prefix `z-`? so that this will be loaded last.
" the loaded order based on the alphabet.
" in case the plugin need settings first before loading the plugin.

" why not put this in `start` directory? so that it's easier to debug.
" everything in the `start` directory will be automatically load, so we need
" to move the plugin directory to `opt` directory (this is the reason why i
" made `PacMove` command).

" the downside of this approach is that i can't use `PacQ` command to check
" how many plugin that got loaded.

" for some reason i can't use `for` loop, still not sure how that works.

packadd vim-surround
packadd targets.vim
packadd traces.vim
packadd vim-commentary
packadd vim-indentwise
packadd bufstop

if !has('nvim')
  packadd vim-lsp
  packadd vim-lsp-settings
endif
