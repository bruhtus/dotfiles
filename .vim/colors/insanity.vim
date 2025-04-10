" -----------------------------------------------------------------------------
" Name:        Insanity
" Author:      Robertus Chris <diawan@pm.me>
" License:     Vim License (see `:help license`)
" Description: Colorscheme for insane people.
" -----------------------------------------------------------------------------

hi clear
let g:colors_name = 'insanity'
set background=dark

if !has('gui_running')
  set t_Co=256
endif

function! s:hi(group, attr, bg, fg, sp) abort
  execute 'highlight! '.a:group . ' ' .
        \ 'cterm='.a:attr[1] . ' ' . 'gui='.a:attr[0] . ' ' .
        \ 'ctermbg='.a:bg[1] . ' ' . 'guibg='.a:bg[0] . ' ' .
        \ 'ctermfg='.a:fg[1] . ' ' . 'guifg='.a:fg[0] . ' ' .
        \ 'guisp='.a:sp[0]
endfunction

" Ref: https://www.ditig.com/256-colors-cheat-sheet
" {{{ Declare default color
let s:bg = ['#121212', 233]
let s:fg_0 = ['#3b3b3b', 237]
let s:fg_1 = ['#808080', 244]
let s:fg_2 = ['#b9b9b9', 250]
let s:fg_3 = ['#ffffff', 231]

let s:red = ['#d75f5f', 167]
let s:green = ['#5faf5f', 71]
let s:yellow = ['#878700', 100]
let s:blue = ['#5f87ff', 69]
let s:magenta = ['#d787af', 175]
let s:cyan = ['#5fafaf', 73]

let s:br_red = ['#ff5f5f', 203]
let s:br_green = ['#87d787', 114]
let s:br_yellow = ['#ffd751', 221]
let s:br_blue = ['#5fafff', 75]
let s:br_magenta = ['#d75fd7', 170]
let s:br_cyan = ['#87ffff', 123]
" }}}

" {{{ Declare terminal color
if !has('nvim')
  " vim built-in terminal emulator
  let g:terminal_ansi_colors = [
        \   s:bg[0],
        \   s:red[0],
        \   s:green[0],
        \   s:yellow[0],
        \   s:blue[0],
        \   s:magenta[0],
        \   s:cyan[0],
        \   s:fg_2[0],
        \   s:fg_1[0],
        \   s:br_red[0],
        \   s:br_green[0],
        \   s:br_yellow[0],
        \   s:br_blue[0],
        \   s:br_magenta[0],
        \   s:br_cyan[0],
        \   s:fg_3[0]
        \ ]
else
  " neovim built-in terminal emulator
  let g:terminal_color_0 = s:bg[0]
  let g:terminal_color_1 = s:red[0]
  let g:terminal_color_2 = s:green[0]
  let g:terminal_color_3 = s:yellow[0]
  let g:terminal_color_4 = s:blue[0]
  let g:terminal_color_5 = s:magenta[0]
  let g:terminal_color_6 = s:cyan[0]
  let g:terminal_color_7 = s:fg_2[0]
  let g:terminal_color_8 = s:fg_1[0]
  let g:terminal_color_9 = s:br_red[0]
  let g:terminal_color_10 = s:br_green[0]
  let g:terminal_color_11 = s:br_yellow[0]
  let g:terminal_color_12 = s:br_blue[0]
  let g:terminal_color_13 = s:br_magenta[0]
  let g:terminal_color_14 = s:br_cyan[0]
  let g:terminal_color_15 = s:fg_3[0]
endif
" }}}

" {{{ Declare attribute
let s:none = ['NONE', 'NONE']
let s:nocombine = ['nocombine,NONE', 'nocombine,NONE']
"}}}

" {{{ Declare default highlight
call s:hi('ColorColumn', s:none, s:fg_0, s:none, s:none)
call s:hi('Conceal', s:nocombine, s:none, s:fg_0, s:none)
call s:hi('Cursor', s:none, s:fg_2, s:bg, s:none)
call s:hi('CursorLineNr', s:none, s:none, s:fg_2, s:none)
call s:hi('Directory', s:none, s:none, s:blue, s:none)
call s:hi('DiffAdd', s:none, s:none, s:green, s:none)
call s:hi('DiffChange', s:none, s:none, s:br_yellow, s:none)
call s:hi('DiffDelete', s:none, s:none, s:red, s:none)
call s:hi('DiffText', s:none, s:red, s:fg_3, s:none)
call s:hi('ErrorMsg', s:nocombine, s:none, s:br_red, s:none)
call s:hi('LineNr', s:none, s:none, s:fg_2, s:none)
call s:hi('LineNrAbove', s:none, s:none, s:fg_1, s:none)
call s:hi('MatchParen', s:none, s:none, s:br_cyan, s:none)
call s:hi('NonText', s:nocombine, s:none, s:fg_1, s:none)
call s:hi('Normal', s:nocombine, s:bg, s:fg_2, s:none)
call s:hi('SignColumn', s:none, s:none, s:none, s:none)
call s:hi('Search', s:none, s:br_magenta, s:fg_3, s:none)
call s:hi('Title', s:none, s:none, s:fg_2, s:none)
call s:hi('QuickFixLine', s:none, s:none, s:green, s:none)
call s:hi('WarningMsg', s:nocombine, s:none, s:br_yellow, s:none)
call s:hi('WildMenu', s:none, s:bg, s:fg_2, s:none)

hi! link lCursor Cursor
hi! link CursorIM Cursor
hi! link CursorColumn ColorColumn
hi! link CursorLine ColorColumn
hi! link CursorLineFold ColorColumn
hi! link CursorLineSign CursorLineNr
hi! link EndOfBuffer NonText
hi! link VertSplit NonText
hi! link Folded NonText
hi! link FoldColumn Conceal
hi! link IncSearch Search
hi! link CurSearch Search
hi! link LineNrBelow LineNrAbove
hi! link MoreMsg WarningMsg
hi! link PopupNotification WarningMsg
hi! link Question WarningMsg
hi! link SpecialKey NonText
hi! link ModeMsg Normal
hi! link Terminal Normal

call s:hi('Pmenu', s:nocombine, s:bg, s:blue, s:none)
call s:hi('PmenuSbar', s:nocombine, s:bg, s:none, s:none)
call s:hi('PmenuSel', s:none, s:bg, s:fg_3, s:none)
call s:hi('PmenuThumb', s:nocombine, s:fg_1, s:none, s:none)

hi! link PmenuKind Pmenu
hi! link PmenuKindSel PmenuSel
hi! link PmenuExtra Pmenu
hi! link PmenuExtraSel PmenuSel
hi! link MessageWindow PmenuSel

call s:hi('SpellBad', s:none, s:none, s:br_red, s:none)
call s:hi('SpellCap', s:none, s:none, s:magenta, s:none)
hi! link SpellLocal Normal
hi! link SpellRare Normal

call s:hi('StatusLine', s:nocombine, s:bg, s:fg_1, s:none)
call s:hi('StatusLineNC', s:nocombine, s:bg, s:yellow, s:none)
hi! link StatuslineTerm StatusLine
hi! link StatuslineTermNC StatusLineNC

call s:hi('TabLine', s:nocombine, s:bg, s:yellow, s:none)
call s:hi('TabLineFill', s:nocombine, s:bg, s:none, s:none)
call s:hi('TabLineSel', s:nocombine, s:bg, s:fg_1, s:none)

call s:hi('Visual', s:none, s:fg_1, s:fg_3, s:none)
hi! link VisualNOS Visual
" }}}

" {{{ Declare general highlight
call s:hi('String', s:nocombine, s:none, s:green, s:none)
call s:hi('Todo', s:none, s:bg, s:br_cyan, s:none)
call s:hi('Comment', s:none, s:bg, s:fg_1, s:none)
call s:hi('Special', s:none, s:bg, s:fg_2, s:none)
call s:hi('Link', s:none, s:none, s:cyan, s:none)

hi! link Ignore Comment
hi! link Function Special
hi! link FunctionBuiltin Special
hi! link Identifier Special
hi! link IdentifierBuiltin Special
hi! link PreProc Special
hi! link Type Special
hi! link TypeBuiltin Normal
hi! link Exception WarningMsg
hi! link Error ErrorMsg
hi! link Character Normal
hi! link Text Normal
hi! link Constant Normal
hi! link Underlined Normal
hi! link Statement Link

hi! link ToolbarLine TabLine
hi! link ToolbarButton TabLineSel
" }}}

" {{{ Declare filetype syntax highlight
" help
hi! link helpHeadline Title
hi! link helpSectionDelim Comment
hi! link helpExample String
hi! link helpBar Comment
hi! link helpHyperTextJump Link
hi! link helpHyperTextEntry Link
hi! link helpVim String
hi! link helpCommand String
hi! link helpHeader String
hi! link helpNote Todo
hi! link helpWarning WarningMsg
hi! link helpDeprecated ErrorMsg
hi! link helpURL Link

" diff
hi! link diffAdded DiffAdd
hi! link diffBDiffer Normal
hi! link diffChanged DiffChange
hi! link diffComment Comment
hi! link diffCommon Normal
hi! link diffDiffer Normal
hi! link diffFile DiffChange
hi! link diffIdentical Normal
hi! link diffIndexLine Normal
hi! link diffIsA Normal
hi! link diffLine Title
hi! link diffNewFile Normal
hi! link diffNoEOL Normal
hi! link diffOldFile Normal
hi! link diffOnly Normal
hi! link diffRemoved DiffDelete
hi! link diffSubname Normal

" markdown
hi! link markdownUrl Link

" git commit
hi! link gitcommitSelectedFile Link
hi! link gitcommitDiscardedFile Link
hi! link gitcommitUntrackedFile Link
hi! link gitcommitSummary String

" vim-sneak
hi! link SneakLabel Search
" }}}

" vim:set et sw=2 foldmethod=marker foldlevel=0:
