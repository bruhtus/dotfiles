" default mappings

" set enter as : except in quickfix window
noremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ':'

" remap backspace to grep the exact under the cursor word in all files
" at current working directory
nnoremap <BS> :execute "lvimgrep /\\<" . expand("<cword>") . "\\>/j **"<CR>

" jump to any mark with space j
nnoremap <leader>j `

" list all the buffer
nnoremap <leader>b :ls<CR>

" open buffer with number list
nnoremap <leader>h :b

" split navigation
nnoremap <C-n> <C-w><C-w>
nnoremap <C-j> <C-w>j<C-w>_
nnoremap <C-k> <C-w>k<C-w>_

" buffer navigation
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>

" remap ctrl-q to behave like default ctrl-l
" ctrl-q default in normal mode behave like ctrl-v (visual block)
nnoremap <C-q> <C-l>

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

" remap ex mode to access vimgrep in current buffer
" you can still access ex mode using gQ
" \v make every following character except a-zA-Z0-9 a special character
nnoremap Q :lvimgrep /\v/j %<left><left><left><left>

" remap _ to set current height window to highest possible
nnoremap _ <C-w>_

" remap + to set current height of each split window to the same height
nnoremap + <C-w>=

" map ]; to cnext and [; to cprevious
nnoremap <silent> ]; :cn<CR>
nnoremap <silent> [; :cp<CR>

" use shift+tab to switch back and forth between two recent buffer
nnoremap <S-Tab> <C-^>

" make pointer in the middle of buffer while half page up/down
nnoremap <C-u> <C-u>M
nnoremap <C-d> <C-d>M

" make pointer in the top/bottom of buffer while page up/down
nnoremap <C-f> <C-f>H
nnoremap <C-b> <C-b>L

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

" map ZJ to move mark m to below current line
nnoremap ZJ :'mm.<CR>

" remap < and > in visual mode
vnoremap < <gv
vnoremap > >gv

" map ctrl-n to switch between split window in terminal
" ctrl-p is a remap in terminal similar to ctrl-w in normal mode
" (check defaults.vim)
tnoremap <C-n> <C-p><C-w>
