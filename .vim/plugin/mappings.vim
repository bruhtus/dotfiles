" default mappings

" set enter as : except in quickfix window and command line window
noremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>zz" :
      \ &buftype ==# 'nofile' ? "\<CR>" : ':'

" remap backspace to grep the exact under the cursor word in all files
" at current working directory
if executable('rg')
  set grepprg=rg\ --smart-case\ --hidden\ --vimgrep\ -w
  set grepformat=%f:%l:%c:%m,%f
  if has('nvim')
    nnoremap <silent> <BS> :silent! lgrep! <cword> **<CR>
  else
    " Ref: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
    " :grep in vanilla vim not as smooth as neovim, it spit out the output
    " into terminal and need to redraw every time using it.
    nnoremap <silent> <BS> :execute "lgetexpr system('" . &grepprg . ' ' . expand("<cword>") . "')"<CR>
  endif

else
  nnoremap <silent> <BS> :execute 'lvimgrep /\v<' . expand('<cword>') . '>/j **'<CR>

endif

" use shift+tab to switch back and forth between two recent buffer
nnoremap <S-Tab> <C-^>

" remap Alt-a to append while in insert mode
" Ref: https://vi.stackexchange.com/a/2363/34851
if !has('nvim') | execute "set <M-a>=\ea" | endif
inoremap <silent> <M-a> <C-o>a

" remap Alt-w to go next word
if !has('nvim') | execute "set <M-w>=\ew" | endif
if exists(':stopinsert') == 2
  inoremap <silent> <M-w> <C-o>w<C-o>:stopinsert<CR>
else
  inoremap <silent> <M-w> <C-o>w<C-[>l
endif

" remap Alt-U (uppercase U) to exit insert mode and yank the entire line and
" put below the given line
inoremap <silent> <M-U> <C-[>:t .<CR>

" remap Alt-~ (tilda) to toggle uppercase in current character in insert mode
" and then escape to normal mode
if !has('nvim') | execute "set <M-~>=\e~" | endif
inoremap <silent> <M-~> <C-o>~<C-[>

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
nnoremap <silent> <leader>p :put +<CR>

" remap _ to set current height window to highest possible
nnoremap _ <C-w>_

" remap + to set current height of each split window to the same height
nnoremap + <C-w>=

" add current line position to jumplist when using `=`
nnoremap = m'=

" add current line position to jumplist before searching
nnoremap / m'/
nnoremap ? m'?

" map ]k to cnext and [k to cprevious
nnoremap <silent> ]k :cn<CR>zz
nnoremap <silent> [k :cp<CR>zz

" map ]l to lnext and [l to lprevious
nnoremap <silent> ]l :lnext<CR>zz
nnoremap <silent> [l :lprevious<CR>zz

" map ]<Space> to location list toggle and [<Space> to quickfix list toggle
" Ref: https://stackoverflow.com/a/63162084
nnoremap <silent> ]<Space>
      \ :if empty(filter(getwininfo(), 'v:val.loclist')) <Bar>
      \   lopen <Bar>
      \ else <Bar>
      \   lclose <Bar>
      \ endif<CR>
nnoremap <silent> [<Space>
      \ :if empty(filter(getwininfo(), 'v:val.quickfix')) <Bar>
      \   copen <Bar>
      \ else <Bar>
      \   cclose <Bar>
      \ endif<CR>

" Ref: https://vim.fandom.com/wiki/Move_to_next/previous_line_with_same_indentation
nnoremap <silent> gb m':<C-u>call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
nnoremap <silent> gh m':<C-u>call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>

" break undo sequence when using `,`, `.`, `ctrl-w`, and `ctrl-u`
inoremap , <C-g>u,
inoremap . .<C-g>u
" inoremap <C-w> <C-g>u<C-w>
" inoremap <C-u> <C-g>u<C-u>

" do not exit visual selection when shift-indenting
vnoremap < <gv
vnoremap > >gv

" set black hole register to c, C, s, S, x, X, D, and space d
nnoremap c "_c
xnoremap c "_c
nnoremap C "_C
nnoremap s "_s
nnoremap S "_S
nnoremap x "_x
xnoremap x "_x
nnoremap X "_X
nnoremap D "_D
nnoremap <leader>d "_d
xnoremap <leader>d "_d

" make search result appear in the middle
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" set cn to substitute current word in a file (use confim as safety guard)
nnoremap cn :%s/<C-r><C-w>//gc<left><left><left>

" set cN to substitute current word in a file (use confim as safety guard)
nnoremap cN :%s/<C-r><C-a>//gc<left><left><left>

" remap Y to yank from pointer to the end of the line
nnoremap Y y$

" didn't move the cursor when using J command
nnoremap J m`J``

" remap U to yank the entire line and put below the given line (takes count)
" default: current line
" add current line to jumplist if v:count more than zero
nnoremap <expr> <silent> U (v:count > 0 ? "m'" . v:count : '') . ":<C-u>execute 't +'. v:count<CR>"

" remap ex mode to access vimgrep in current buffer
" you can still access ex mode using gQ
" \v make every following character except a-zA-Z0-9 a special character
nnoremap Q :lvimgrep /\v/j %<left><left><left><left>

" set space s to substitute command
nnoremap <leader>s :s//g<left><left>

" set space m to open terminal emulator
if exists(':ter')
  nnoremap <silent> <leader>m :ter<CR>
endif

" set ZX as :w
nnoremap ZX :w<CR>

" set ZA as :on
nnoremap <silent> ZA :on<CR>

" set ZS to grep word under cursor in current buffer
nnoremap <silent> ZS :execute 'lvimgrep /\v<' . expand('<cword>') . '>/j %'<CR>

" set ZD to grep WORD under cursor in current buffer
nnoremap <silent> ZD :execute 'lvimgrep /' . expand('<cWORD>') . '/j %'<CR>

" set ZC as :reg
nnoremap <silent> ZC :reg<CR>

" map ZJ to move current line below the given line (takes count) and add the
" current line position to jumplist
" default: current line
nnoremap <expr> <silent> ZJ
      \ v:count1 > 1 ? ":<C-u>execute '+1k` <Bar> move +'. v:count1<CR>" :
      \ ":<C-u>execute 'move +'. v:count1<CR>"

" map ZJ to move current line below the given line (takes count) and add the
" current line position to jumplist (visual mode)
" default: above or below current selected line
xnoremap <silent> ZJ
      \ :<C-u>if v:count1 > 1 <Bar>
      \   execute "+1k' <Bar> '<,'>move '>+". v:count1 <Bar>
      \ else <Bar>
      \   execute "'<,'>move '>+". v:count1 <Bar>
      \ endif<CR>gv

" map ZK to move current line above the given line (takes count) and add the
" current line position to jumplist
" default: corrent line
nnoremap <expr> <silent> ZK
      \ v:count1 > 1 ? ":<C-u>execute '-1k` <Bar> move -1-'. v:count1<CR>" :
      \ ":<C-u>execute 'move -1-'. v:count1<CR>"

" map ZK to move current line above the given line (takes count) and add the
" current line position to jumplist (visual mode)
" default: above or below current selected line
xnoremap <silent> ZK
      \ :<C-u>if v:count1 > 1 <Bar>
      \   execute "-1k' <Bar> '<,'>move '<-1-". v:count1 <Bar>
      \ else <Bar>
      \   execute "'<,'>move '<-1-". v:count1 <Bar>
      \ endif<CR>gv

" map ZU to yank the entire line and put above the given line (takes count)
" default: current line
" add current line to jumplist if v:count more than zero
nnoremap <expr> <silent> ZU (v:count > 0 ? "m'" . v:count : '') . ":<C-u>execute 't -1-'. v:count<CR>"

function! s:copy_visual(direction) abort
  if a:direction ==# 'above'
    execute "'<,'>t '<-1-" . v:count
  elseif a:direction ==# 'below'
    execute "'<,'>t '>+" . v:count
  endif
endfunction

xnoremap <expr> <silent> zj (v:count > 0 ? "m'" . v:count : '') . ":<C-u>call <SID>copy_visual('below')<CR>"
xnoremap <expr> <silent> zk (v:count > 0 ? "m'" . v:count : '') . ":<C-u>call <SID>copy_visual('above')<CR>"

" map ZH to put blank character above, and ZN to put blank character below
" can use count to add how many blank character to insert
" it respect `startofline` option, so turn that off if you don't want the
" cursor to move
nnoremap <silent> ZH :<C-u>put!=repeat((nr2char(10)), v:count1)<Bar>']+1<CR>
nnoremap <silent> ZN :<C-u>put =repeat((nr2char(10)), v:count1)<Bar>'[-1<CR>

" use ctrl-k/j to go up/down in command line history
cnoremap <C-k> <up>
cnoremap <C-j> <down>

" no double `/` when tapping `/` while using wildmenu
" Ref: https://github.com/Gavinok/dotvim/blob/190356011fa2da232481cf5e4068a404f5827914/vimrc#L291-L295
if has('nvim-0.5')
  cnoremap <expr> / wildmenumode() ? "\<C-y>" : "/"
else
  cnoremap <expr> / wildmenumode() ? "\<C-e>" : "/"
endif

" use ctrl-s to move left and ctrl-x to move right in command line mode
" check `:h cmdline` to make sure you didn't remap the useful one
cnoremap <C-s> <left>
cnoremap <C-x> <right>

" mapping to interact with built-in terminal
if has('nvim')
  tnoremap <C-Space> <C-\><C-n>

elseif has('patch-8.0.0877')
  " Vim Patch: http://ftp.vim.org/pub/vim/patches/8.0/
  " Use Plugin: tweekmonster/helpful.vim
  " for whatever reason i can't use ctrl space in vim
  " vim interprets <Nul> or <C-@> when you press ctrl-space
  tnoremap <C-@> <C-\><C-n>

endif

" Ref: https://vi.stackexchange.com/a/693
" nnoremap <buffer> <silent> cd m':<C-u>call search('\%' . virtcol('.') . 'v\S', 'W')<CR>
" nnoremap <buffer> <silent> dc m':<C-u>call search('\%' . virtcol('.') . 'v\S', 'bW')<CR>

" Ref: https://github.com/jeetsukumaran/vim-linearly/blob/master/plugin/linearly.vim
" Usage: make `J` normal mode command take motion
" function! s:_joinoperator(submode)
"   '[,']join
" endfunction
" nnoremap J :set operatorfunc=<SID>_joinoperator<CR>g@

" add location to jumplist if moving more than 5 count
" for example: it's gonna add the location to jumplist if we use `6j`
" backtick mark apparently can add to the jumplist
" nnoremap <expr> j (v:count > 5 ? 'm`' . v:count : '') . 'j'
" nnoremap <expr> k (v:count > 5 ? 'm`' . v:count : '') . 'k'

" didn't quite find this mapping useful but can be good for reference
" set space S to substitute N occurrence using command line window
" nnoremap <leader>S q:is/\v(.{-}\zs){}/<Esc>F)i

" edit the current word and next word occurrence by pressing dot command
" nnoremap cn *``"_cgn
" nnoremap cN #``"_cgN

" experiment to make j remapped to `_` if the next line of the same column is
" blank/whitespace character
" nnoremap <expr> j match(getline('.'), '\S') + 1 ># col('.') ? '_' : 'j'

" to find out highlight group used in current curror possition
" Ref: https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
" pressing <F1> open help menu
" nnoremap <F2> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
"       \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
"       \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>