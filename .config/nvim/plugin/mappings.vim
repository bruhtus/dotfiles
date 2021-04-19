" default mappings

" set enter as : except in quickfix window and command line window
noremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>zz" :
			\ &buftype ==# 'nofile' ? "\<CR>" : ':'

" remap backspace to grep the exact under the cursor word in all files
" at current working directory
if executable('rg')
	set grepprg=rg\ --smart-case\ --hidden\ --vimgrep\ -w
	nnoremap <BS> :silent! lgrep! <cword> **<CR>

else
	nnoremap <BS> :execute "lvimgrep /\\<" . expand("<cword>") . "\\>/j **"<CR>

endif

" use shift+tab to switch back and forth between two recent buffer
nnoremap <S-Tab> <C-^>

" split navigation
" nnoremap <C-n> <C-w><C-w>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

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
nnoremap <silent> ]; :cn<CR>zz
nnoremap <silent> [; :cp<CR>zz

" map ]<Space> to lnext and [<Space> to lprevious
nnoremap <silent> ]<Space> :lnext<CR>zz
nnoremap <silent> [<Space> :lprevious<CR>zz

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

" make search result appear in the middle
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" remap Y to yank from pointer to the end of the line
nnoremap Y y$

" remap U to yank the entire line and put below the given line (takes count)
" default: current line
nnoremap U :<C-u>execute 't +'. v:count<cr>

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

" set ZS to grep word under cursor in current buffer
nnoremap ZS :execute "lvimgrep /\\<" . expand("<cword>") . "\\>/j %"<CR>

" set ZD as :reg
nnoremap ZD :reg<CR>

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

nnoremap <silent> ZB :<C-u>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> Z<Space> :<C-u>call <SID>BlankDown(v:count1)<CR>

" map ZJ to move current line below the given line (takes count)
" default: current line
nnoremap ZJ :<C-u>execute 'move +'. v:count1<cr>

" map ZK to move current line above the given line (takes count)
" default: corrent line
nnoremap ZK :<C-u>execute 'move -1-'. v:count1<cr>

" map ZU to yank the entire line and put above the given line (takes count)
" default: current line
nnoremap ZU :<C-u>execute 't -1-'. v:count<cr>

" map ZN to yank mark m and put below current line
nnoremap ZN :'mt.<CR>

" map ZH to yank mark m and put above current line
nnoremap ZH :'mt.-1<CR>

" use ctrl-k/j to go up/down in command line history
cnoremap <C-k> <up>
cnoremap <C-j> <down>

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

" make incsearch appear in the middle
augroup VimIncsearch
	autocmd!
	autocmd CmdlineEnter /,\? :setlocal scrolloff=999 | cnoremap <CR> <CR>zz | redraw
	autocmd CmdlineLeave /,\? :setlocal scrolloff=-1 | cunmap <CR>
augroup END
