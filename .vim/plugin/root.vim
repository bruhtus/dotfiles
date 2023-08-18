finish
" minimalist vim-rooter alternative

" inspired by tpope's vim-sensible plugin
" doesn't support autochdir option
if &autochdir
  set noautochdir
endif

let g:root_pattern = ['.git', '=nvim', 'vimrc']

augroup root_buffer
  autocmd!
  autocmd BufEnter *
        \ if !exists('b:root_enabled') |
        \   silent! lcd %:p:h          |
        \ else                         |
        \   unlet b:root_enabled       |
        \   silent! lcd %:p:h          |
        \   call root#toggle()         |
        \ endif
augroup END

nnoremap <silent> _ :call root#toggle()<CR>
