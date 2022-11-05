" File:         enfocadomod.vim
" URL:          github.com/junegunn/seoul256.vim
" Author:       Junegunn Choi (junegunn.c@gmail.com)
"               Wuelner Martínez (wuelner.martinez@outlook.com)
"               Robertus Chris (diawan@pm.me)
" License:      MIT
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if !exists('s:rgb_map')
  let s:rgb_map =
        \{ 16: '#000000',  17: '#00005f',  18: '#000087',
        \  19: '#0000af',  20: '#0000d7',  21: '#0000ff',
        \  22: '#005f00',  23: '#005f5f',  24: '#005f87',
        \  25: '#005faf',  26: '#005fd7',  27: '#005fff',
        \  28: '#008700',  29: '#00875f',  30: '#008787',
        \  31: '#0087af',  32: '#0087d7',  33: '#0087ff',
        \  34: '#00af00',  35: '#00af5f',  36: '#00af87',
        \  37: '#00afaf',  38: '#00afd7',  39: '#00afff',
        \  40: '#00d700',  41: '#00d75f',  42: '#00d787',
        \  43: '#00d7af',  44: '#00d7d7',  45: '#00d7ff',
        \  46: '#00ff00',  47: '#00ff5f',  48: '#00ff87',
        \  49: '#00ffaf',  50: '#00ffd7',  51: '#00ffff',
        \  52: '#5f0000',  53: '#5f005f',  54: '#5f0087',
        \  55: '#5f00af',  56: '#5f00d7',  57: '#5f00ff',
        \  58: '#5f5f00',  59: '#5f5f5f',  60: '#5f5f87',
        \  61: '#5f5faf',  62: '#5f5fd7',  63: '#5f5fff',
        \  64: '#5f8700',  65: '#5f875f',  66: '#5f8787',
        \  67: '#5f87af',  68: '#5f87d7',  69: '#368aeb',
        \  70: '#5faf00',  71: '#70b433',  72: '#5faf87',
        \  73: '#5fafaf',  74: '#5fafd7',  75: '#4f9cfe',
        \  76: '#5fd700',  77: '#5fd75f',  78: '#5fd787',
        \  79: '#3fc5b7',  80: '#56d8c9',  81: '#5fd7ff',
        \  82: '#5fff00',  83: '#5fff5f',  84: '#5fff87',
        \  85: '#5fffaf',  86: '#5fffd7',  87: '#5fffff',
        \  88: '#870000',  89: '#87005f',  90: '#870087',
        \  91: '#8700af',  92: '#8700d7',  93: '#8700ff',
        \  94: '#875f00',  95: '#875f5f',  96: '#875f87',
        \  97: '#875faf',  98: '#875fd7',  99: '#875fff',
        \ 100: '#878700', 101: '#87875f', 102: '#878787',
        \ 103: '#8787af', 104: '#8787d7', 105: '#8787ff',
        \ 106: '#87af00', 107: '#87af5f', 108: '#87af87',
        \ 109: '#87afaf', 110: '#87afd7', 111: '#87afff',
        \ 112: '#87d700', 113: '#83c746', 114: '#87d787',
        \ 115: '#87d7af', 116: '#87d7d7', 117: '#87d7ff',
        \ 118: '#87ff00', 119: '#87ff5f', 120: '#87ff87',
        \ 121: '#87ffaf', 122: '#87ffd7', 123: '#87ffff',
        \ 124: '#af0000', 125: '#af005f', 126: '#af0087',
        \ 127: '#af00af', 128: '#af00d7', 129: '#af00ff',
        \ 130: '#af5f00', 131: '#af5f5f', 132: '#af5f87',
        \ 133: '#af5faf', 134: '#af5fd7', 135: '#af5fff',
        \ 136: '#af8700', 137: '#af875f', 138: '#af8787',
        \ 139: '#af87af', 140: '#a580e2', 141: '#b891f5',
        \ 142: '#afaf00', 143: '#afaf5f', 144: '#afaf87',
        \ 145: '#afafaf', 146: '#afafd7', 147: '#afafff',
        \ 148: '#afd700', 149: '#afd75f', 150: '#afd787',
        \ 151: '#afd7af', 152: '#afd7d7', 153: '#afd7ff',
        \ 154: '#afff00', 155: '#afff5f', 156: '#afff87',
        \ 157: '#afffaf', 158: '#afffd7', 159: '#afffff',
        \ 160: '#d70000', 161: '#d7005f', 162: '#d70087',
        \ 163: '#d700af', 164: '#d700d7', 165: '#d700ff',
        \ 166: '#d75f00', 167: '#d75f5f', 168: '#d75f87',
        \ 169: '#d75faf', 170: '#d75fd7', 171: '#d75fff',
        \ 172: '#d78700', 173: '#e67f43', 174: '#d78787',
        \ 175: '#d787af', 176: '#d787d7', 177: '#d787ff',
        \ 178: '#d7af00', 179: '#dbb32d', 180: '#d7af87',
        \ 181: '#d7afaf', 182: '#d7afd7', 183: '#d7afff',
        \ 184: '#d7d700', 185: '#d7d75f', 186: '#d7d787',
        \ 187: '#d7d7af', 188: '#d7d7d7', 189: '#d7d7ff',
        \ 190: '#d7ff00', 191: '#d7ff5f', 192: '#d7ff87',
        \ 193: '#d7ffaf', 194: '#d7ffd7', 195: '#d7ffff',
        \ 196: '#ff0000', 197: '#ff005f', 198: '#ff0087',
        \ 199: '#ff00af', 200: '#ff00d7', 201: '#ff00ff',
        \ 202: '#ff5f00', 203: '#ff5f5f', 204: '#ff5f87',
        \ 205: '#eb6eb7', 206: '#ff5fd7', 207: '#ff5fff',
        \ 208: '#ff8700', 209: '#fa9153', 210: '#ff8787',
        \ 211: '#ff87af', 212: '#ff81ca', 213: '#ff87ff',
        \ 214: '#ffaf00', 215: '#ffaf5f', 216: '#ffaf87',
        \ 217: '#ffafaf', 218: '#ffafd7', 219: '#ffafff',
        \ 220: '#ffd700', 221: '#efc541', 222: '#ffd787',
        \ 223: '#ffd7af', 224: '#ffd7d7', 225: '#ffd7ff',
        \ 226: '#ffff00', 227: '#ffff5f', 228: '#ffff87',
        \ 229: '#ffffaf', 230: '#ffffd7', 231: '#ffffff',
        \ 232: '#080808', 233: '#121212', 234: '#1c1c1c',
        \ 235: '#262626', 236: '#303030', 237: '#3a3a3a',
        \ 238: '#444444', 239: '#4e4e4e', 240: '#585858',
        \ 241: '#626262', 242: '#6c6c6c', 243: '#767676',
        \ 244: '#808080', 245: '#8a8a8a', 246: '#949494',
        \ 247: '#9e9e9e', 248: '#a8a8a8', 249: '#b2b2b2',
        \ 250: '#bcbcbc', 251: '#c6c6c6', 252: '#d0d0d0',
        \ 253: '#dadada', 254: '#e4e4e4', 255: '#eeeeee' }
endif

" Background colors
let s:dark_bg  = 233
let s:dark_bg_2 = 232

" Foreground colors
let s:dark_fg = 250

function! s:hi(item, fg, bg)
  let fg = a:fg[0] > 255 ? 231 : a:fg[0]
  let bg = a:bg[0] > 255 ? 231 : a:bg[0]

  if !empty(fg)
    execute printf("highlight %s ctermfg=%s guifg=%s", a:item, fg, get(s:rgb_map, fg, 'NONE'))
  endif
  if !empty(bg)
    execute printf("highlight %s ctermbg=%s guibg=%s", a:item, bg, get(s:rgb_map, bg, 'NONE'))
  endif
endfunction

let s:gui = has('gui_running')
if !s:gui
  set t_Co=256
end

unlet! g:colors_name
hi clear
if exists("syntax_on")
  syntax reset
endif

call s:hi('Normal', [s:dark_fg], [s:dark_bg])

call s:hi('LineNr', [240], [s:dark_bg])

call s:hi('Visual', [''],
      \ [!exists('$DISPLAY') && $TERM ==# 'tmux-256color' ?
      \ 4 : exists('$DISPLAY') ? 23 : 44])
call s:hi('VisualNOS', [''],
      \ [!exists('$DISPLAY') && $TERM ==# 'tmux-256color' ?
      \ 4 : exists('$DISPLAY') ? 23 : 44])

call s:hi('Comment',         [243],       [''])
call s:hi('Number',          [s:dark_fg], [''])
call s:hi('Float',           [s:dark_fg], [''])
call s:hi('Boolean',         [98],        [''])
call s:hi('String',          [79],        [''])
call s:hi('Constant',        [s:dark_fg], [''])
call s:hi('Character',       [37],        [''])
call s:hi('Delimiter',       [s:dark_fg], [''])
call s:hi('StringDelimiter', [s:dark_fg], [''])
call s:hi('Statement',       [69],        [''])
" case, default, etc.
" hi Label ctermfg=

" if else end
call s:hi('Conditional', [69], [''])

" while end
call s:hi('Repeat',   [69],  [''])
call s:hi('Todo',     [161], [s:dark_bg])
call s:hi('Function', [113], [''])

" Macros
call s:hi('Define',    [69], [''])
call s:hi('Macro',     [69], [''])
call s:hi('Include',   [69], [''])
call s:hi('PreCondit', [69], [''])


" #!
call s:hi('PreProc', [69], [''])

" @abc
call s:hi('Identifier', [71], [''])

" AAA Abc
call s:hi('Type', [75], [''])

" + - * / <<
call s:hi('Operator', [69], [''])

" super yield
call s:hi('Keyword', [69], [''])

" raise
call s:hi('Exception', [173], [''])
"
" hi StorageClass ctermfg=
call s:hi('Structure', [75], [''])
" hi Typedef ctermfg=

call s:hi('Error',      [203], ['NONE'])
call s:hi('ErrorMsg',   [203], ['NONE'])
call s:hi('Underlined', [181], [''])

" set textwidth=80
" set colorcolumn=+1
call s:hi('ColorColumn', [''], [exists('$DISPLAY') ? 237 : 244])

" highlight blank line
" Ref: https://stackoverflow.com/a/706083
" Ref: https://stackoverflow.com/a/27897508
augroup highlight_blank_lines
  autocmd!
  autocmd VimEnter,WinEnter * match ColorColumn /^$/
augroup END

" GVIM only
" hi Cursor ctermfg=
" hi CursorIM ctermfg=

" set cursorline cursorcolumn
call s:hi('CursorLine',   [''],    [s:dark_bg - 1])
call s:hi('CursorLineNr', ['250'], [s:dark_bg])
call s:hi('CursorColumn', [''],    [s:dark_bg - 1])
call s:hi('NormalFloat',  [''],    [s:dark_bg - 1])

call s:hi('Directory', [75], [''])

call s:hi('DiffAdd',    [71],        ['NONE'])
call s:hi('DiffDelete', [203],       ['NONE'])
call s:hi('DiffChange', [179],       ['NONE'])
call s:hi('DiffText',   [s:dark_bg], [s:dark_fg])

call s:hi('VertSplit', [s:dark_bg], [59])
call s:hi('Folded',    [243],       [s:dark_bg + 1])

" set foldcolumn=1
call s:hi('FoldColumn', [243], [s:dark_bg + 1])

call s:hi('MatchParen', [''], [62])

" -- INSERT --
call s:hi('ModeMsg', [s:dark_fg], [''])

" let &showbreak = '> '
call s:hi('NonText', [59], [''])

call s:hi('MoreMsg', [221], [''])

" Popup menu
call s:hi('Pmenu',      [250], [234])
call s:hi('PmenuSel',   [252], [238])
call s:hi('PmenuSbar',  [''],  [235])
call s:hi('PmenuThumb', [''],  [237])

call s:hi('Search',    [s:dark_fg], [24])
call s:hi('IncSearch', [179],       [232])

" String delimiter, interpolation
call s:hi('Special', [141], [''])
" hi SpecialChar ctermfg=
" hi SpecialComment ctermfg=
" hi Tag ctermfg=
" hi Debug ctermfg=

" :map, listchars
call s:hi('SpecialKey', [237], [''])

if !s:gui
  " Red / Blue / Cyan / Magenta
  hi SpellBad   ctermbg=NONE cterm=underline ctermfg=168
  hi SpellCap   ctermbg=NONE cterm=underline ctermfg=110
  hi SpellLocal ctermbg=NONE cterm=underline ctermfg=153
  hi SpellRare  ctermbg=NONE cterm=underline ctermfg=218
else
  execute 'hi SpellBad   gui=undercurl guisp=' . s:rgb_map[168]
  execute 'hi SpellCap   gui=undercurl guisp=' . s:rgb_map[110]
  execute 'hi SpellLocal gui=undercurl guisp=' . s:rgb_map[153]
  execute 'hi SpellRare  gui=undercurl guisp=' . s:rgb_map[218]
endif

" statusline
call s:hi('StatusLine',       [s:dark_bg],     [245])
call s:hi('StatusLineNC',     [s:dark_bg],     [243])
call s:hi('StatusLineTerm',   [s:dark_bg],     [151])
call s:hi('StatusLineTermNC', [s:dark_bg + 2], [187])
hi StatusLineTerm cterm=bold,reverse gui=bold,reverse
hi StatusLineTermNC cterm=bold,reverse gui=bold,reverse

call s:hi('TabLineFill', [s:dark_bg],      [''])
call s:hi('TabLineSel',  [252],            [233])
call s:hi('TabLine',     [s:dark_bg + 12], [s:dark_bg + 4])
call s:hi('WildMenu',    [s:dark_bg],      [187])

" :set all
call s:hi('Title', [253], [''])

" TODO
call s:hi('Question', [179], [''])

" Search hit bottom
call s:hi('WarningMsg', [179], [''])

" Sign column
call s:hi('SignColumn', [173], [s:dark_bg])

" Diff
call s:hi('diffAdded',   [108], [''])
call s:hi('diffRemoved', [174], [''])
hi link diffLine Constant

call s:hi('Conceal', [s:dark_fg + 2], [s:dark_bg - 1])
call s:hi('Ignore',  [s:dark_bg + 3], [s:dark_bg])

" ~ symbol at the end of buffer
" call s:hi('EndOfBuffer',  [s:dark_bg], [''])

" statusline mode color
call s:hi('NormalModeColor',  [233], [187])
call s:hi('InsertModeColor',  [233], [151])
call s:hi('VisualModeColor',  [233], [152])
call s:hi('CommandModeColor', [233], [217])

"""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""

" vim-easymotion
" -----------
" call s:hi('EasyMotionTarget',        [152], [''])
" call s:hi('EasyMotionTarget2First',  [224], [''])
" call s:hi('EasyMotionTarget2Second', [217], [''])

" hop.nvim
" -----------
" call s:hi('HopNextKey',   [152],           [''])
" call s:hi('HopNextKey1',  [224],           [''])
" call s:hi('HopNextKey2',  [217],           [''])
" call s:hi('HopUnmatched', [s:dark_bg + 8], [''])

" vim-sneak
" -----------
call s:hi('Sneak',      [s:dark_bg], [230])
call s:hi('SneakLabel', [120], [232])

" Ref: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" ---------------------------------------------------^^^^^
call s:hi('ExtraWhitespace', [''], [s:dark_bg - 1])

" vim-ruby
" --------
" " rubySymbol
" let ruby_operators = 1
" call s:hi('rubyClass',               [31,  31],  ['', ''])
" call s:hi('rubyInstanceVariable',    [189, 189], ['', ''])
" call s:hi('rubyRegexp',              [186, 101], ['', ''])
" call s:hi('rubyRegexpDelimiter',     [168, 168], ['', ''])
" call s:hi('rubyArrayDelimiter',      [67,  38],  ['', ''])
" call s:hi('rubyBlockParameterList',  [186, 94],  ['', ''])
" call s:hi('rubyCurlyBlockDelimiter', [144, 101], ['', ''])

" ARGV $stdout
" call s:hi('rubyPredefinedIdentifier', [230, 52], ['', ''])
" hi rubyRegexpSpecial

hi CursorLine cterm=NONE
hi CursorLineNr cterm=NONE

" hi MatchWord cterm=underline gui=underline

" change statusline color when enter insert mode
" autocmd! InsertEnter * call s:hi('StatusLine', [233], [151])
" autocmd! InsertLeave * call s:hi('StatusLine', [233], [187])

" set built-in terminal emulator colors when `termguicolors` on
if has('nvim')
  let g:terminal_color_0 = '#121212'
  let g:terminal_color_1 = '#d78787'
  let g:terminal_color_2 = '#afd7af'
  let g:terminal_color_3 = '#d7d7af'
  let g:terminal_color_4 = '#afd7ff'
  let g:terminal_color_5 = '#ffafd7'
  let g:terminal_color_6 = '#5fafaf'
  let g:terminal_color_7 = '#d0d0d0'
  let g:terminal_color_8 = '#171717'
  let g:terminal_color_9 = '#e09b99'
  let g:terminal_color_10 = '#bcddbd'
  let g:terminal_color_11 = '#dfdebd'
  let g:terminal_color_12 = '#bce0ff'
  let g:terminal_color_13 = '#ffc0de'
  let g:terminal_color_14 = '#6fbcbd'
  let g:terminal_color_15 = '#d9d9d9'

elseif has('terminal')
  let g:terminal_ansi_colors = [
        \ '#121212',
        \ '#d78787',
        \ '#afd7af',
        \ '#d7d7af',
        \ '#afd7ff',
        \ '#ffafd7',
        \ '#5fafaf',
        \ '#d0d0d0',
        \ '#171717',
        \ '#e09b99',
        \ '#bcddbd',
        \ '#dfdebd',
        \ '#bce0ff',
        \ '#ffc0de',
        \ '#6fbcbd',
        \ '#d9d9d9'
        \ ]

endif

let g:seoul256_current_fg = [s:dark_fg][0]
let g:seoul256_current_bg = [s:dark_bg][0]
let g:colors_name = 'enfocadomod'
