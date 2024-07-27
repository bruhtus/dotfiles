" default mappings

" set enter as : except in quickfix window and command line window
" nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" :
"       \ &buftype ==# 'nofile' ? "\<CR>" : ':'

" xnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" :
"       \ &buftype ==# 'nofile' ? "\<CR>" : ':'

" remap backspace to grep the exact under the cursor word in all files
" at current working directory
" Ref: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
" :grep in vanilla vim not as smooth as neovim, it spit out the output
" into terminal and need to redraw every time using it.
nnoremap <silent> <BS> :execute "cgetexpr system('"
      \ . &grepprg . ' -w -e ' . expand("<cword>") . "')"
      \ <Bar> botright cwindow<CR>

" Ref: https://stackoverflow.com/q/1533565
function! s:prev_visual_selection() abort
  return getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]
endfunction

" remap backspace to grep word in visual selection in all files at current
" working directory
" result: execute 'lgetexpr system("grepprg 'visual text'")'
xnoremap <silent> <BS> :<C-u>execute 'cgetexpr system("'
      \ . &grepprg . ' -w --fixed-strings -e ' . "'" . <SID>prev_visual_selection() . "'" . '")'
      \ <Bar> botright cwindow<CR>

" set ZS to grep word under cursor in current buffer
nnoremap <silent> ZS :execute 'lvimgrep /\M\<' . expand('<cword>') . '\>/j %' <Bar>
      \ lwindow<CR>

" set ZS to grep visual selection in current buffer
xnoremap <silent> ZS :<C-u>execute
      \ 'lvimgrep /\M' . <SID>prev_visual_selection() . '/j %' <Bar>
      \ lwindow<CR>

" set ZD to grep WORD under cursor in current buffer
nnoremap <silent> ZD :execute 'lvimgrep /\M' . expand('<cWORD>') . '/j %' <Bar>
      \ lwindow<CR>

function! s:custom_grep() abort
  let l:choice = confirm('Use current working directory?',
        \ "&JYes\n&KNo\n&NCancel", 3)
  redraw

  if l:choice == 1
    " do nothing
  elseif l:choice == 2
    call inputsave()
    let l:path = input('Path: ', '', 'file')
    call inputrestore()
    redraw
    let g:last_search_path = expand(l:path)
  elseif l:choice == 3
    return
  endif

  call inputsave()
  let l:keyword = input('Grep: ')
  call inputrestore()
  redraw

  if !empty(l:keyword)
    " Interpretation:
    " system('grepprg --fixed-strings -e' . shellescape(l:keyword) . ' l:path')
    execute "cgetexpr system('"
          \ . &grepprg . " --fixed-strings -e '" . " . shellescape(l:keyword)"
          \ . ((!exists('l:path') || empty(l:path)) ? '' : " . ' " . expand(l:path) . "'") . ')'

    botright cwindow
  else
    echo 'Nothing to grep'
  endif
endfunction

nnoremap <silent> <leader>o :<C-u>call <SID>custom_grep()<CR>

" use ctrl-s to toggle between two recent buffer
nnoremap <C-s> <C-6>

" use ctrl-r ctrl-d to get current file directory
cnoremap <C-r><C-d> <C-r>=expand('%:p:h')<CR>

" use ctrl-r ctrl-e to get the last search path if exist
cnoremap <C-r><C-e> <C-r>=exists('g:last_search_path') ? g:last_search_path : ''<CR>

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

" remap Alt-W to go next word
if !has('nvim') | execute "set <M-W>=\eW" | endif
if exists(':stopinsert') == 2
  inoremap <silent> <M-W> <C-o>W<C-o>:stopinsert<CR>
else
  inoremap <silent> <M-W> <C-o>W<C-[>l
endif

" remap Alt-U (uppercase U) to exit insert mode and yank the entire line and
" put below the given line
inoremap <silent> <M-U> <C-[>:t .<CR>

" remap Alt-~ (tilda) to toggle uppercase in current character in insert mode
" and then escape to normal mode
if !has('nvim') | execute "set <M-~>=\e~" | endif
inoremap <silent> <M-~> <C-o>~<C-[>

" highlight word under cursor
nnoremap <expr> <silent> <C-h>
      \ ':<C-u>match Search /'
      \ . (empty(expand('<cword>')) ? '\m^$' : '\M\<' . expand('<cword>') . '\>')
      \ . '/<CR>'

" update diff in diff mode first, and then clear match, finally redraw the
" screen
nnoremap <expr> <silent> <C-l>
      \ (&diff ? ':<C-u>diffupdate <Bar> ' : ':<C-u>') . 'match none<CR>'
      \ . '<C-l>'

" remap ctrl-c to esc (or ctrl-[)
" there's a different between ctrl-c default and esc, like when exit while
" editing using visual block
inoremap <C-c> <C-[>

" make pointer in the middle of buffer while half page up/down
" nnoremap <C-u> <C-u>M^
" nnoremap <C-d> <C-d>M^

" make pointer in the top/bottom of buffer while page up/down
" nnoremap <C-f> <C-f>H^
" nnoremap <C-b> <C-b>L^

" Ref: https://vim.fandom.com/wiki/Move_to_next/previous_line_with_same_indentation
function! s:move_same_indentation(reverse, visual) abort
  let l:flags = (a:reverse ? 'b' : '') . 'seW'
  let l:pattern = '^' . matchstr(getline('.'), '\(^\s*\)')
        \ . '\%' . (a:reverse ? '<' : '>') . '.l\S'

  " skip if previous or next line has the same indentation and non-blank lines
  let l:skip_expr = "indent('.') == indent(line('.')"
        \ . (a:reverse ? '+' : '-') . "1)"
        \ . " && getline(line('.')"
        \ . (a:reverse ? '+' : '-') . "1) !~# '^$'"

  if a:visual
    norm! gv
  endif

  return search(l:pattern, l:flags, 0, 0, l:skip_expr)
endfunction

nnoremap <silent> <C-j> :<C-u>call <SID>move_same_indentation(0, 0)<CR>
nnoremap <silent> <C-k> :<C-u>call <SID>move_same_indentation(1, 0)<CR>
xnoremap <silent> <C-j> :<C-u>call <SID>move_same_indentation(0, 1)<CR>
xnoremap <silent> <C-k> :<C-u>call <SID>move_same_indentation(1, 1)<CR>

" set vim to copy to clipboard
" remove new line character in clipboard register
" Ref: https://stackoverflow.com/q/20735923
xnoremap <silent> <leader>y "+y:let @+=substitute(@+, '\n$', '', 'g')<CR>

" set vim to paste from clipboard
nnoremap <C-n> "+gp
nnoremap <C-p> "+gP
nnoremap <silent> <leader>p :put +<CR>
nnoremap <silent> <leader>P :put! +<CR>

" remap + to set signcolumn to yes
nnoremap <silent> + :<C-u>setlocal signcolumn=yes<CR>

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

" Ref:
" https://github.com/tpope/vim-unimpaired/blob/master/plugin/unimpaired.vim#L193-L195
function! s:conflict_marker(reverse, visual) abort
  if a:visual
    norm! gv
  endif

  return search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

" conflict navigation
" Ref: https://vi.stackexchange.com/a/2706
nnoremap <silent> ]= :<C-u>call <SID>conflict_marker(0, 0)<CR>
nnoremap <silent> [= :<C-u>call <SID>conflict_marker(1, 0)<CR>
xnoremap <silent> ]= :<C-u>call <SID>conflict_marker(0, 1)<CR>
xnoremap <silent> [= :<C-u>call <SID>conflict_marker(1, 1)<CR>


" map ]<Space> to location list toggle and [<Space> to quickfix list toggle
" Ref: https://stackoverflow.com/a/63162084
if exists('*getwininfo()')
  nnoremap <expr> <silent> ]<Space>
        \ empty(filter(getwininfo(), 'v:val.loclist')) ?
        \ ':botright lwindow<CR>' :
        \ ':botright lclose <Bar> wincmd p<CR>'
  nnoremap <expr> <silent> [<Space>
        \ empty(filter(getwininfo(), 'v:val.quickfix')) ?
        \ ':botright cwindow<CR>' :
        \ ':botright cclose <Bar> wincmd p<CR>'
endif

" do not exit visual selection when shift-indenting
xnoremap < <gv
xnoremap > >gv
xnoremap = =gv

" update diff color after diffget
nnoremap <silent> do do:diffupdate<CR>

" set black hole register to c, C, s, S, x, X, d, and D
nnoremap c "_c
xnoremap c "_c
nnoremap C "_C
nnoremap s "_s
nnoremap S "_S
nnoremap x "_x
xnoremap x "_x
nnoremap X "_X
nnoremap <expr> d v:register == '"' ? '"_d' : 'd'
xnoremap <expr> d v:register == '"' ? '"_d' : 'd'
nnoremap <expr> D v:register == '"' ? '"_D' : 'D'

" set space d to default d command
nnoremap <leader>d d
xnoremap <leader>d d

" set space D to default D normal mode command
nnoremap <leader>D D

" make search result appear in the middle
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz

" set cu to substitute current word in all lines (use confirm as safety guard)
" Ref: https://vi.stackexchange.com/a/34390 (direct positioning command line)
nnoremap cu :keeppatterns %s/\v<<C-r><C-w>>//gc<C-r>=setcmdpos(getcmdpos()-3)[1]<CR>

" set cU to substitute current WORD in all lines (use confirm as safety guard)
nnoremap cU :keeppatterns %s/\v<<C-r><C-a>>//gc<C-r>=setcmdpos(getcmdpos()-3)[1]<CR>

" set cd to substitute current word in current line (use confirm as safety guard)
nnoremap cd :keeppatterns s/<C-r><C-w>//gc<C-r>=setcmdpos(getcmdpos()-3)[1]<CR>

" set cD to substitute current WORD in current line (use confirm as safety guard)
nnoremap cD :keeppatterns s/<C-r><C-a>//gc<C-r>=setcmdpos(getcmdpos()-3)[1]<CR>

" delete below or above current line but exclude the current line
" TODO: make operator pending mapping for K and J
nnoremap <silent> dK :<C-u>exe "k' <Bar> -" . v:count1 . ',-1d_'<CR>g``
nnoremap <silent> dJ :<C-u>exe "k' <Bar> +1,+" . v:count1 . 'd_'<CR>g``

" remap Y to yank from pointer to the end of the line
" nnoremap Y y$

" toggle 'number' option (useful for pair programming)
nnoremap <silent> yon :<C-u>set number!<CR>

" toggle `relativenumber` option
nnoremap <silent> yor :<C-u>setlocal relativenumber!<CR>

" toggle `spell` option
nnoremap <silent> yos :<C-u>setlocal spell!<CR>

" remap U to yank the entire line and put below the given line (takes count)
" default: current line
" add current line to jumplist if v:count more than zero
nnoremap <expr> <silent> U
      \ (v:count > 0 ? "m'" . v:count : '') . ":<C-u>execute 't +' . v:count<CR>"

" show unix time as human-readable. 1690773718 => '2023-07-31 10:21:58'
" Ref:
" https://github.com/justinmk/config/commit/ef788ed68a1d3cabc4e29c12869d9af1aef02c8c
nnoremap <silent> gA :<C-u>echo strftime('%Y-%m-%d %H:%M:%S', '<c-r><c-w>')<cr>

" print current working directory
nnoremap <leader><Space> :<C-u>pwd<CR>

" print current git branch
nnoremap <expr> <silent> <leader>.
      \ exists('*GitBranch()') ?
      \ ':<C-u>echo GitBranch()<CR>' :
      \ ':<C-u>echo "GitBranch() does not exist"<CR>'

" toggle focus current window
nnoremap <expr> <silent> <leader>z
      \ winnr('$') != 1 ?
      \ !exists('t:zoom') ?
      \ ':<C-u>let t:zoom = winrestcmd() <Bar> resize <Bar> vertical resize<CR>' :
      \ ':<C-u>exe t:zoom <Bar> unlet t:zoom<CR>' :
      \ ':<C-u>echoerr "Only one window" <Bar> unlet! t:zoom<CR>'

" set space s to substitute command
nnoremap <leader>s :keeppatterns s
xnoremap <leader>s :<C-u>keeppatterns '<,'>s

" set space S to spawn keeppatterns command
nnoremap <leader>S :<C-u>keeppatterns

" set space a to remove the entire line that match pattern
" similar to `:g/pattern/d_`
" Ref: https://vi.stackexchange.com/a/26153
nnoremap <leader>a :keeppatterns %s/.*.*\n//c<C-r>=setcmdpos(getcmdpos()-7)[1]<CR>

nnoremap <leader>v :'<,'>

" set ZX as :update
nnoremap <silent> ZX :up<CR>

" update active buffer if the file changed
" Ref: https://vi.stackexchange.com/a/13092
nnoremap <silent> ZA :<C-u>windo checktime<CR>

" set ZC as :reg
" nnoremap <silent> ZC :reg<CR>

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
" Ref: https://vimtricks.com/p/reselect-pasted-text/
xnoremap <expr> <silent> zj
      \ (v:count > 0 ? "m'" . v:count : '')
      \ . ':<C-u>execute "' . "'<,'>t '>+" . '" . v:count<CR>' . "'[V']"

" map zk to yank the entire visual selection and put above the given line
" (takes count)
" default: current line
" Ref: https://vimtricks.com/p/reselect-pasted-text/
xnoremap <expr> <silent> zk
      \ (v:count > 0 ? "m'" . v:count : '')
      \ . ':<C-u>execute "' . "'<,'>t '<-1-" . '" . v:count<CR>' . "'[V']"

" map ZH to put blank character above, and ZN to put blank character below
" can use count to add how many blank character to insert
" it respect `startofline` option, so turn that off if you don't want the
" cursor to move
nnoremap <silent> ZH :<C-u>put!=repeat((nr2char(10)), v:count1)<Bar>']+1<CR>
nnoremap <silent> ZN :<C-u>put =repeat((nr2char(10)), v:count1)<Bar>'[-1<CR>

" use ctrl-k/j to go up/down in command line history
" cnoremap <C-k> <up>
" cnoremap <C-j> <down>

" no double `/` when tapping `/` while using wildmenu
" Ref: https://github.com/Gavinok/dotvim/blob/190356011fa2da232481cf5e4068a404f5827914/vimrc#L291-L295
" if has('nvim-0.5')
"   cnoremap <expr> / wildmenumode() ? "\<C-y>" : "/"
" else
"   cnoremap <expr> / wildmenumode() ? "\<C-e>" : "/"
" endif

" use ctrl-x to move left and ctrl-s to move right in command line mode
" check `:h cmdline` to make sure you didn't remap the useful one
" cnoremap <C-x> <left>
" cnoremap <C-s> <right>

" mapping to interact with built-in terminal
" if has('nvim')
"   tnoremap <C-Space> <C-\><C-n>
" elseif has('patch-8.0.0877')
"   " Vim Patch: http://ftp.vim.org/pub/vim/patches/8.0/
"   " Use Plugin: tweekmonster/helpful.vim
"   " for whatever reason i can't use ctrl space in vim
"   " vim interprets <Nul> or <C-@> when you press ctrl-space
"   tnoremap <C-@> <C-\><C-n>
" endif

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
