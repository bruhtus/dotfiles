" default mappings

" set enter as : except in quickfix window
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ':'

" jump to any mark with space j
nnoremap <leader>j `

" split navigation
nnoremap <C-n> <C-w><C-w>
nnoremap <C-j> <C-w>j<C-w>_
nnoremap <C-k> <C-w>k<C-w>_

" buffer navigation
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>

" remap ctrl-c to esc (or ctrl-[)
" there's a different between ctrl-c default and esc, like when exit while
" editing using visual block
inoremap <C-c> <C-[>

" set black hole register to c, C, s, S, x, X, D, and space d
nnoremap c "_c
nnoremap C "_C
nnoremap s "_s
nnoremap S "_S
nnoremap x "_x
nnoremap X "_X
nnoremap D "_D
nnoremap <leader>d "_d

" remap Y to yank from pointer to the end of the line
nnoremap Y y$

" remap U to yank the entire line and put below that line
nnoremap U :t.<CR>

" remap _ to set current height window to highest possible
nnoremap _ <C-w>_

" remap + to set current height of each split window to the same height
nnoremap + <C-w>=

" Use shift+tab to switch back and forth between two recent buffer
nnoremap <S-Tab> <C-^>

" set vim to copy to clipboard and paste from clipboard
vnoremap <C-y> "+y
nnoremap <C-p> "+gp

" set ZX as :w
nnoremap ZX :w<CR>

" set ZA as :on
nnoremap ZA :on<CR>

" set ZC as :filetype detect
nnoremap ZC :filetype detect<CR>

" set ZS as :reg
nnoremap ZS :reg<CR>

" set ZD as :marks
nnoremap ZD :marks<CR>

" set ZW to enter blank space below and ZE to enter blank space above
nnoremap ZW m`o<Esc>``
nnoremap ZE m`O<Esc>``

" remap < and > in visual mode
vnoremap < <gv
vnoremap > >gv
