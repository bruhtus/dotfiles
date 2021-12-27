" default mappings

" set enter as : except in quickfix window and command line window
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>zz" :
      \ &buftype ==# 'nofile' ? "\<CR>" : ':'

xnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>zz" :
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
" Ref: https://vi.stackexchange.com/a/2706
nnoremap <expr> <C-j> &diff ? ']c' : '<C-w>j'
nnoremap <expr> <C-k> &diff ? '[c' : '<C-w>k'
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

" set vim to copy to clipboard
" remove new line character in clipboard register
" Ref: https://stackoverflow.com/q/20735923
xnoremap <silent> <leader>y "+y:let @+=substitute(@+, '\n$', '', 'g')<CR>

" set vim to paste from clipboard
nnoremap <C-p> "+gp
nnoremap <silent> <leader>p :put +<CR>
nnoremap <silent> <leader>P :put! +<CR>

" remap _ to set current height window to highest possible
nnoremap _ <C-w>_

" remap + to set current height of each split window to the same height
nnoremap + <C-w>=

" add current line position to jumplist when using `=`
nnoremap = m'=

" add current line position to jumplist before searching
nnoremap / m'/
nnoremap ? m'?

" map [q and ]q to go to previous/next saved state
nnoremap <silent> [q :ea1f<CR>
nnoremap <silent> ]q :lat1f<CR>

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
nnoremap <silent> gB m':<C-u>call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>

" do not exit visual selection when shift-indenting
xnoremap < <gv
xnoremap > >gv

" set black hole register to c, C, s, S, x, X, d, and D
nnoremap c "_c
xnoremap c "_c
nnoremap C "_C
nnoremap s "_s
nnoremap S "_S
nnoremap x "_x
xnoremap x "_x
nnoremap X "_X
nnoremap d "_d
xnoremap d "_d
nnoremap D "_D

" set space d to default d command
nnoremap <leader>d d
xnoremap <leader>d d

" set space D to default D normal mode command
nnoremap <leader>D D

" make search result appear in the middle
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" set cu to substitute current word in all lines (use confim as safety guard)
nnoremap cu :%s/\v<<C-r><C-w>>//gc<left><left><left>

" set cU to substitute current WORD in all lines (use confim as safety guard)
nnoremap cU :%s/\v<<C-r><C-a>>//gc<left><left><left>

" set cd to substitute current word in current line (use confim as safety guard)
nnoremap cd :s/<C-r><C-w>//gc<left><left><left>

" set cD to substitute current WORD in current line (use confim as safety guard)
nnoremap cD :s/<C-r><C-a>//gc<left><left><left>

" remap Y to yank from pointer to the end of the line
nnoremap Y y$

" remap U to yank the entire line and put below the given line (takes count)
" default: current line
" add current line to jumplist if v:count more than zero
nnoremap <expr> <silent> U
      \ (v:count > 0 ? "m'" . v:count : '') . ":<C-u>execute 't +' . v:count<CR>"

" remap ex mode to access vimgrep in current buffer
" you can still access ex mode using gQ
" \v make every following character except a-zA-Z0-9 a special character
nnoremap Q :lvimgrep /\v/j %<left><left><left><left>

" print current working directory
nnoremap <leader>; :<C-u>pwd<CR>

" toggle `relativenumber` option (useful when pairing)
nnoremap <silent> <leader>r :<C-u>setl relativenumber!<CR>

" set space s to substitute command
nnoremap <leader>s :s//g<left><left>

" set space a to remove the entire line that match pattern
" similar to `:g/pattern/d_`
" Ref: https://vi.stackexchange.com/a/26153
nnoremap <leader>a :%s/.*.*\n//c<left><left><left><left><left><left><left>

" set space m to open terminal emulator
if exists(':ter')
  nnoremap <silent> <leader>m :ter<CR>
endif

" set ZX as :update
nnoremap <silent> ZX :up<CR>

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
      \ (v:count1 > 1 ? ':<C-u>execute "' . "+1k' <Bar> " : ':<C-u>execute "')
      \ . 'move +" . v:count1<CR>'

" map ZJ to move current line below the given line (takes count) and add the
" current line position to jumplist (visual mode)
" default: above or below current selected line
xnoremap <expr> <silent> ZJ
      \ (v:count1 > 1 ? ':<C-u>execute "' . "'>+1k' <Bar> " : ':<C-u>execute "')
      \ . "'<,'>move '>+" . '" . v:count1<CR>gv'

" map ZK to move current line above the given line (takes count) and add the
" current line position to jumplist
" default: corrent line
nnoremap <expr> <silent> ZK
      \ (v:count1 > 1 ? ':<C-u>execute "' . "-1k' <Bar> " : ':<C-u>execute "')
      \ . 'move -1-" . v:count1<CR>'

" map ZK to move current line above the given line (takes count) and add the
" current line position to jumplist (visual mode)
" default: above or below current selected line
xnoremap <expr> <silent> ZK
      \ (v:count1 > 1 ? ':<C-u>execute "' . "'<-1k' <Bar> " : ':<C-u>execute "')
      \ . "'<,'>move '<-1-" . '" . v:count1<CR>gv'

" map ZU to yank the entire line and put above the given line (takes count)
" default: current line
" add current line to jumplist if v:count more than zero
nnoremap <expr> <silent> ZU
      \ (v:count > 0 ? "m'" . v:count : '') . ":<C-u>execute 't -1-' . v:count<CR>"

" map zj to yank the entire visual selection and put below the given line
" (takes count)
" default: current line
xnoremap <expr> <silent> zj
      \ (v:count > 0 ? "m'" . v:count : '')
      \ . ':<C-u>execute "' . "'<,'>t '>+" . '" . v:count<CR>'

" map zk to yank the entire visual selection and put above the given line
" (takes count)
" default: current line
xnoremap <expr> <silent> zk
      \ (v:count > 0 ? "m'" . v:count : '')
      \ . ':<C-u>execute "' . "'<,'>t '<-1-" . '" . v:count<CR>'

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
