" -----------------------------------------------------------------------------
" Name:        Enfocado for Vim
" Author:      Wuelner Martínez <wuelner.martinez@outlook.com>
"              Robertus Chris <diawan@pm.me>
" URL:         https://github.com/wuelnerdotexe/vim-enfocado
" License:     MIT (C) Wuelner Martínez.
" Description: How themes should be.
" About:       Enfocado is more than a theme, it is a concept of 'how themes
"              should be', focusing on what is really important to developers:
"              the code and nothing else.
" -----------------------------------------------------------------------------

hi clear
let g:colors_name = 'enfocadomod'

let s:hasTermguicolors = has('termguicolors') ? 1 : 0
let s:hasGui_running = has('gui_running') ? 1 : 0

if !s:hasGui_running
  set t_Co=256
endif

" Ref: https://www.ditig.com/256-colors-cheat-sheet
function s:hi(group, attr, bg, fg, sp)
  execute 'highlight! '.a:group . ' ' .
        \ 'cterm='.a:attr[1] . ' ' . 'gui='.a:attr[0] . ' ' .
        \ 'ctermbg='.a:bg[1] . ' ' . 'guibg='.a:bg[0] . ' ' .
        \ 'ctermfg='.a:fg[1] . ' ' . 'guifg='.a:fg[0] . ' ' .
        \ 'guisp='.a:sp[0]
endfunction

" The color scheme to use are assigned.
let s:bg_0 = ['#121212', 233]
let s:bg_1 = ['#252525', 235]
let s:bg_2 = ['#3b3b3b', 237]
let s:dim_0 = ['#808080', 244]
let s:fg_0 = ['#b9b9b9', 250]
let s:fg_1 = ['#dedede', 253]

let s:red = ['#d75f5f', 167]
let s:green = ['#5faf5f', 71]
let s:yellow = ['#ffd700', 220]
let s:blue = ['#5f87ff', 69]
let s:magenta = ['#d787af', 175]
let s:cyan = ['#5fafaf', 73]
let s:orange = ['#d7875f', 173]
let s:violet = ['#af87d7', 140]

let s:br_red = ['#ff5f5f', 203]
let s:br_green = ['#87d787', 114]
let s:br_yellow = ['#ffd751', 221]
let s:br_blue = ['#5fafff', 75]
let s:br_magenta = ['#ffafd7', 218]
let s:br_cyan = ['#87ffff', 123]
let s:br_orange = ['#ffaf87', 216]
let s:br_violet = ['#af87ff', 141]

let s:base = ['#000000', 16]

let s:accent_0 = s:green
let s:accent_1 = s:blue
let s:br_accent_0 = s:green
let s:br_accent_1 = s:blue

" Attributes are declared.
let s:none = ['NONE', 'NONE']
let s:nocombine = ['nocombine,NONE', 'nocombine,NONE']
let s:bold = ['nocombine,bold', 'nocombine,bold']
let s:italic = ['nocombine,italic', 'nocombine,italic']
let s:underline = ['underline', 'underline']
let s:undercurl = ['undercurl', 'undercurl']

" Vim terminal variables are assigned.
let g:terminal_ansi_colors = [
      \   s:bg_1[0],
      \   s:red[0],
      \   s:green[0],
      \   s:yellow[0],
      \   s:blue[0],
      \   s:magenta[0],
      \   s:cyan[0],
      \   s:dim_0[0],
      \   s:bg_2[0],
      \   s:br_red[0],
      \   s:br_green[0],
      \   s:br_yellow[0],
      \   s:br_blue[0],
      \   s:br_magenta[0],
      \   s:br_cyan[0],
      \   s:fg_1[0]
      \ ]

" Neovim terminal variables are assigned.
let g:terminal_color_0 = s:bg_1[0]
let g:terminal_color_1 = s:red[0]
let g:terminal_color_2 = s:green[0]
let g:terminal_color_3 = s:yellow[0]
let g:terminal_color_4 = s:blue[0]
let g:terminal_color_5 = s:magenta[0]
let g:terminal_color_6 = s:cyan[0]
let g:terminal_color_7 = s:dim_0[0]
let g:terminal_color_8 = s:bg_2[0]
let g:terminal_color_9 = s:br_red[0]
let g:terminal_color_10 = s:br_green[0]
let g:terminal_color_11 = s:br_yellow[0]
let g:terminal_color_12 = s:br_blue[0]
let g:terminal_color_13 = s:br_magenta[0]
let g:terminal_color_14 = s:br_cyan[0]
let g:terminal_color_15 = s:fg_1[0]

" ------------------------------------------------------------------------------
" SECTION: Vim base groups highlighting.
" ------------------------------------------------------------------------------
" General interface.
call s:hi('IncSearch', s:none, s:br_yellow, s:bg_1, s:none)
call s:hi('Search', s:none, s:br_yellow, s:bg_1, s:none)
call s:hi('LineNr', s:none, s:none, s:dim_0, s:none)
call s:hi('Accent', s:none, s:none, s:br_accent_0, s:none)
call s:hi('Builtin', s:none, s:none, s:br_magenta, s:none)
call s:hi('ColorColumn', s:italic, s:bg_1, s:none, s:none)
call s:hi('Conceal', s:nocombine, s:none, s:bg_2, s:none)
call s:hi('Cursor', s:none, s:fg_0, s:bg_1, s:none)
call s:hi('CursorColumn', s:none, s:bg_1, s:none, s:none)
call s:hi('CursorLine', s:none, s:bg_1, s:none, s:none)
call s:hi('CursorLineNr', s:none, s:none, s:fg_1, s:none)
call s:hi('DiffAdd', s:none, s:none, s:green, s:none)
call s:hi('DiffChange', s:none, s:none, s:yellow, s:none)
call s:hi('DiffDelete', s:none, s:none, s:red, s:none)
call s:hi('DiffText', s:none, s:fg_0, s:bg_0, s:none)
call s:hi('Dimmed', s:nocombine, s:none, s:dim_0, s:none)
call s:hi('Directory', s:none, s:none, s:blue, s:none)
call s:hi('ErrorMsg', s:nocombine, s:none, s:br_red, s:none)
call s:hi('FileLink', s:none, s:none, s:br_cyan, s:none)
call s:hi('FileExec', s:nocombine, s:none, s:green, s:none)
call s:hi('FloatBorder', s:nocombine, s:bg_1, s:br_accent_0, s:none)
call s:hi('Folded', s:nocombine, s:none, s:dim_0, s:none)
call s:hi('FoldColumn', s:nocombine, s:none, s:bg_2, s:none)
call s:hi('Ignore', s:nocombine, s:none, s:bg_2, s:none)
call s:hi('lCursor', s:none, s:fg_0, s:bg_1, s:none)
call s:hi('LineNrAbove', s:none, s:none, s:dim_0, s:none)
call s:hi('Match', s:none, s:none, s:br_accent_0, s:none)
call s:hi('MatchFuzzy', s:nocombine, s:none, s:accent_0, s:none)
call s:hi('MatchParen', s:none, s:none, s:br_orange, s:none)
call s:hi('ModeMsg', s:nocombine, s:none, s:fg_0, s:none)
call s:hi('MoreMsg', s:nocombine, s:none, s:br_yellow, s:none)
call s:hi('None', s:none, s:none, s:none, s:none)
call s:hi('NonText', s:nocombine, s:none, s:dim_0, s:none)
call s:hi('Normal', s:nocombine, s:bg_0, s:fg_0, s:none)
call s:hi('NormalFloat', s:nocombine, s:bg_1, s:fg_0, s:none)
call s:hi('NvimInternalError', s:nocombine, s:none, s:br_red, s:none)
call s:hi('Pmenu', s:nocombine, s:bg_0, s:dim_0, s:none)
call s:hi('PmenuSbar', s:nocombine, s:bg_1, s:none, s:none)
call s:hi('PmenuSel', s:none, s:bg_2, s:fg_0, s:none)
call s:hi('PmenuThumb', s:nocombine, s:dim_0, s:none, s:none)
call s:hi('Question', s:nocombine, s:none, s:br_yellow, s:none)
call s:hi('QuickFixLine', s:none, s:bg_1, s:br_accent_0, s:none)
call s:hi('RedrawDebugClear', s:none, s:none, s:br_yellow, s:none)
call s:hi('RedrawDebugComposed', s:none, s:none, s:green, s:none)
call s:hi('RedrawDebugNormal', s:none, s:none, s:fg_1, s:none)
call s:hi('RedrawDebugRecompose', s:none, s:none, s:br_red, s:none)
call s:hi('SignColumn', s:none, s:none, s:none, s:none)
call s:hi('SpecialKey', s:nocombine, s:none, s:dim_0, s:none)
call s:hi('SpellBad', s:underline, s:none, s:red, s:red)
call s:hi('SpellCap', s:underline, s:none, s:blue, s:blue)
call s:hi('SpellLocal', s:underline, s:none, s:cyan, s:cyan)
call s:hi('SpellRare', s:underline, s:none, s:magenta, s:magenta)
call s:hi('StatusLine', s:nocombine, s:bg_0, s:fg_0, s:none)
call s:hi('StatusLineNC', s:nocombine, s:bg_0, s:dim_0, s:none)
call s:hi('StatuslineTerm', s:nocombine, s:bg_1, s:dim_0, s:none)
call s:hi('StatuslineTermNC', s:nocombine, s:bg_1, s:bg_2, s:none)
call s:hi('Success', s:nocombine, s:none, s:green, s:none)
call s:hi('TabLine', s:nocombine, s:bg_1, s:dim_0, s:none)
call s:hi('TabLineFill', s:nocombine, s:bg_0, s:fg_0, s:none)
call s:hi('TabLineSel', s:nocombine, s:none, s:fg_0, s:none)
call s:hi('TermCursor', s:none, s:fg_0, s:bg_1, s:none)
call s:hi('Title', s:none, s:none, s:fg_1, s:none)
call s:hi('ToolbarButton', s:nocombine, s:accent_0, s:bg_1, s:none)
call s:hi('ToolbarLine', s:nocombine, s:bg_1, s:dim_0, s:none)
call s:hi('VertSplit', s:nocombine, s:none, s:dim_0, s:none)
call s:hi('Visual', s:italic, s:bg_2, s:none, s:none)
call s:hi('VisualNC', s:italic, s:bg_2, s:none, s:none)
call s:hi('VisualNOS', s:italic, s:bg_2, s:none, s:none)
call s:hi('WarningMsg', s:nocombine, s:none, s:br_orange, s:none)
call s:hi('WildMenu', s:none, s:bg_0, s:br_accent_0, s:none)
highlight! link CursorLineSign CursorLineNr
highlight! link CursorLineFold CursorLine
highlight! link EndOfBuffer NonText
highlight! link Line ColorColumn
highlight! link LineNrBelow LineNrAbove
highlight! link MsgArea Text
highlight! link MsgSeparator StatusLineNC
highlight! link NormalNC Normal
highlight! link Substitute Search
highlight! link TermCursorNC None
highlight! link Whitespace NonText
highlight! link WinBar Text
highlight! link WinBarNC Dimmed
highlight! link WinSeparator VertSplit
if has('nvim')
  highlight! FloatShadow ctermbg=16 guibg=#000000 blend=10
  highlight! FloatShadowThrough ctermbg=16 guibg=#000000 blend=10
endif

" General syntax.
call s:hi('Comment', s:none, s:none, s:dim_0, s:none)
call s:hi('ConstIdentifier', s:none, s:none, s:yellow, s:none)
call s:hi('Error', s:none, s:none, s:br_red, s:none)
call s:hi('Trace', s:nocombine, s:none, s:br_magenta, s:none)
call s:hi('Exception', s:nocombine, s:none, s:orange, s:none)
call s:hi('Function', s:none, s:none, s:br_accent_0, s:none)
call s:hi('FunctionBuiltin', s:none, s:none, s:br_magenta, s:none)
call s:hi('Identifier', s:nocombine, s:none, s:accent_0, s:none)
call s:hi('IdentifierBuiltin', s:nocombine, s:none, s:magenta, s:none)
call s:hi('Link', s:none, s:none, s:br_cyan, s:br_cyan)
call s:hi('PreProc', s:nocombine, s:none, s:accent_1, s:none)
call s:hi('Special', s:nocombine, s:none, s:br_violet, s:none)
call s:hi('Statement', s:nocombine, s:none, s:accent_1, s:none)
call s:hi('StatementBuiltin', s:nocombine, s:none, s:violet, s:none)
call s:hi('String', s:nocombine, s:none, s:cyan, s:br_cyan)
call s:hi('Text', s:nocombine, s:none, s:fg_0, s:none)
call s:hi('Todo', s:none, s:br_cyan, s:base, s:none)
call s:hi('Type', s:none, s:none, s:br_accent_1, s:none)
call s:hi('TypeBuiltin', s:none, s:none, s:br_violet, s:none)
highlight! link Boolean StatementBuiltin
highlight! link Character String
highlight! link Conditional Statement
highlight! link Constant Text
highlight! link Debug Dimmed
highlight! link Define PreProc
highlight! link Delimiter Text
highlight! link Float Number
highlight! link Include PreProc
highlight! link Keyword Statement
highlight! link Label Statement
highlight! link Macro Define
highlight! link Method Function
highlight! link Number Constant
highlight! link Operator Statement
highlight! link PreCondit PreProc
highlight! link Property Type
highlight! link Repeat Statement
highlight! link SpecialChar StatementBuiltin
highlight! link SpecialComment StatementBuiltin
highlight! link StorageClass Type
highlight! link Structure Type
highlight! link Tag Statement
highlight! link Typedef Type
highlight! Underlined term=none cterm=none gui=none

" Neovim diagnostic.
if has('nvim')
  call s:hi('DiagnosticError', s:none, s:none, s:br_red, s:none)
  call s:hi('DiagnosticHint', s:none, s:none, s:blue, s:none)
  call s:hi('DiagnosticInfo', s:none, s:none, s:br_yellow, s:none)
  call s:hi('DiagnosticWarn', s:none, s:none, s:br_orange, s:none)
  call s:hi('DiagnosticFloatingError', s:none, s:bg_1, s:br_red, s:none)
  call s:hi('DiagnosticFloatingHint', s:none, s:bg_1, s:blue, s:none)
  call s:hi('DiagnosticFloatingInfo', s:none, s:bg_1, s:br_yellow, s:none)
  call s:hi('DiagnosticFloatingWarn', s:none, s:bg_1, s:br_orange, s:none)
  call s:hi('DiagnosticUnderlineError', s:undercurl, s:none, s:none, s:br_red)
  call s:hi('DiagnosticUnderlineHint', s:undercurl, s:none, s:none, s:blue)
  call s:hi('DiagnosticUnderlineInfo', s:undercurl, s:none, s:none, s:br_yellow)
  call s:hi('DiagnosticUnderlineWarn', s:undercurl, s:none, s:none, s:br_orange)
  if (s:hasTermguicolors && &termguicolors) || s:hasGui_running
    call s:hi('DiagnosticVirtualTextError', s:none, s:bg_0, s:br_red, s:none)
    call s:hi('DiagnosticVirtualTextHint', s:none, s:bg_0, s:blue, s:none)
    call s:hi('DiagnosticVirtualTextInfo', s:none, s:bg_0, s:br_yellow, s:none)
    call s:hi('DiagnosticVirtualTextWarn', s:none, s:bg_0, s:br_orange, s:none)
  else
    highlight! link DiagnosticVirtualTextError DiagnosticFloatingError
    highlight! link DiagnosticVirtualTextHint DiagnosticFloatingHint
    highlight! link DiagnosticVirtualTextInfo DiagnosticFloatingInfo
    highlight! link DiagnosticVirtualTextWarn DiagnosticFloatingWarn
  endif
  highlight! link DiagnosticSignError DiagnosticError
  highlight! link DiagnosticSignHint DiagnosticHint
  highlight! link DiagnosticSignInfo DiagnosticInfo
  highlight! link DiagnosticSignWarn DiagnosticWarn
endif

" ------------------------------------------------------------------------------
" SECTION: Filetypes syntax groups highlighting.
" ------------------------------------------------------------------------------
" Help.
highlight! link helpHeadline Title
highlight! link helpSectionDelim Dimmed
highlight! link helpExample Text
highlight! link helpBar Dimmed
highlight! link helpHyperTextJump String
highlight! link helpHyperTextEntry String
highlight! link helpVim Accent
highlight! link helpCommand Text
highlight! link helpHeader Title
highlight! link helpNote Todo
highlight! link helpWarning DiagnosticWarn
highlight! link helpDeprecated DiagnosticError
highlight! link helpURL Link

" Diff.
highlight! link diffAdded DiffAdd
highlight! link diffBDiffer Text
highlight! link diffChanged DiffChange
highlight! link diffComment Comment
highlight! link diffCommon Text
highlight! link diffDiffer Text
highlight! link diffFile Text
highlight! link diffIdentical Text
highlight! link diffIndexLine Text
highlight! link diffIsA Text
highlight! link diffLine Title
highlight! link diffNewFile Text
highlight! link diffNoEOL Text
highlight! link diffOldFile Text
highlight! link diffOnly Text
highlight! link diffRemoved DiffDelete
highlight! link diffSubname Title

" vim-sneak
call s:hi('SneakLabel', s:none, s:base, ['#87ff87', 120], s:none)
