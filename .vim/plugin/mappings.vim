" default mappings

" set enter as :
map <CR> :

" jump to any mark with space j
nnoremap <leader>j `

" Split navigation
nnoremap <C-h> <C-w><C-w>
nnoremap <C-J> <C-w>j<C-w>_
nnoremap <C-K> <C-w>k<C-w>_

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

" remap _ to set current height window to highest possible
nnoremap _ <C-w>_

" remap _ to set current height window to highest possible
nnoremap + <C-w>=

" set vim to copy to clipboard and paste from clipboard
vnoremap <C-y> "+y
nnoremap <C-p> "+p

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
