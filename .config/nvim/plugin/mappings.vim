" default mappings

" set enter as : except in quickfix window
noremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ':'

" remap backspace to grep the exact under the cursor word in all files
" at current working directory
if executable('rg')
	set grepprg=rg\ --smart-case\ --hidden\ --vimgrep\ -w
	nnoremap <BS> :silent! lgrep! <cword> **<CR>

else
	nnoremap <BS> :execute "lvimgrep /\\<" . expand("<cword>") . "\\>/j **"<CR>

endif

" jump to any mark with space j
nnoremap <leader>j `

" list all the buffer
nnoremap <leader>b :ls<CR>

" open buffer with number list
nnoremap <leader>n :ls<CR>:b

" use shift+tab to switch back and forth between two recent buffer
nnoremap <S-Tab> <C-^>

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

" make pointer in the middle of buffer while half page up/down
nnoremap <C-u> <C-u>M^
nnoremap <C-d> <C-d>M^

" make pointer in the top/bottom of buffer while page up/down
nnoremap <C-f> <C-f>H^
nnoremap <C-b> <C-b>L^

" set vim to copy to clipboard and paste from clipboard
vnoremap <C-y> "+y
nnoremap <C-p> "+gp

" remap _ to set current height window to highest possible
nnoremap _ <C-w>_

" remap + to set current height of each split window to the same height
nnoremap + <C-w>=

" map ]; to cnext and [; to cprevious
nnoremap <silent> ]; :cn<CR>
nnoremap <silent> [; :cp<CR>

" do not exit visual selection when shift-indenting
vnoremap < <gv
vnoremap > >gv

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

" map Z<Space> to enter blank space below and ZB to enter blank space above
" stole this from vim-unimpaired plugin (sorry lord tpope)
function! s:BlankUp(count) abort
	norm m`
	put!=repeat(nr2char(10), a:count)
	norm ``
endfunction

function! s:BlankDown(count) abort
	norm m`
	put =repeat(nr2char(10), a:count)
	norm ``
endfunction

nnoremap <silent> ZB :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> Z<Space> :<C-U>call <SID>BlankDown(v:count1)<CR>

" map ZJ to move mark m to below current line
nnoremap ZJ :'mm.<CR>

" map ZK to move mark m to above current line
nnoremap ZK :'mm.-1<CR>

" map ZU to yank the entire line and put above that line
nnoremap ZU :t.-1<CR>

" map ZN to yank mark m and put below current line
nnoremap ZN :'mt.<CR>

" map ZH to yank mark m and put above current line
nnoremap ZH :'mt.-1<CR>

" mapping to interact with built-in terminal
if has('nvim')
	tnoremap <C-n> <C-\><C-n>
	" set mark T in terminal buffer first and then call mark T
	nnoremap <leader>m `T

elseif exists('&termwinkey')
	" ctrl-p is a remap in terminal similar to ctrl-w in normal mode
	" (check defaults.vim)
	tnoremap <C-n> <C-p><C-n>

endif
