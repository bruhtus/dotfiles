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

" A funcref is created to get the color scheme based on the vim background.
function! s:get_colors()
  " Colors are initialized.
  let l:colors = {}

  " Dark or light scheme is initialized.
  if &background ==# 'dark'
    " Selenized black color scheme.
    let l:colors.bg_0 = ['#181818', 234]
    let l:colors.bg_1 = ['#252525', 235]
    let l:colors.bg_2 = ['#3b3b3b', 237]
    let l:colors.dim_0 = ['#777777', 243]
    let l:colors.fg_0 = ['#b9b9b9', 250]
    let l:colors.fg_1 = ['#dedede', 253]

    let l:colors.red = ['#ed4a46', 203]
    let l:colors.green = ['#70b433', 71]
    let l:colors.yellow = ['#dbb32d', 179]
    let l:colors.blue = ['#368aeb', 69]
    let l:colors.magenta = ['#eb6eb7', 205]
    let l:colors.cyan = ['#3fc5b7', 79]
    let l:colors.orange = ['#e67f43', 173]
    let l:colors.violet = ['#a580e2', 140]

    let l:colors.br_red = ['#ff5e56', 203]
    let l:colors.br_green = ['#83c746', 113]
    let l:colors.br_yellow = ['#efc541', 221]
    let l:colors.br_blue = ['#4f9cfe', 75]
    let l:colors.br_magenta = ['#ff81ca', 212]
    let l:colors.br_cyan = ['#56d8c9', 80]
    let l:colors.br_orange = ['#fa9153', 209]
    let l:colors.br_violet = ['#b891f5', 141]

    " Base background color.
    let l:colors.base = ['#000000', 16]

    " Pseudo transparency colors.
    let l:colors.blend_error = ['#462624', 'NONE']
    let l:colors.blend_hint = ['#233246', 'NONE']
    let l:colors.blend_info = ['#433a20', 'NONE']
    let l:colors.blend_warn = ['#453024', 'NONE']
    let l:colors.blend_added = ['#2c3326', 'NONE']
    let l:colors.blend_modified = ['#2c281b', 'NONE']
    let l:colors.blend_removed = ['#2e1e1d', 'NONE']
    let l:colors.blend_search = ['#62552e', 'NONE']
  else
    " Selenized white color scheme.
    let l:colors.bg_0 = ['#ffffff', 231]
    let l:colors.bg_1 = ['#ebebeb', 255]
    let l:colors.bg_2 = ['#cdcdcd', 252]
    let l:colors.dim_0 = ['#878787', 245]
    let l:colors.fg_0 = ['#474747', 238]
    let l:colors.fg_1 = ['#282828', 235]

    let l:colors.red = ['#d6000c', 160]
    let l:colors.green = ['#1d9700', 28]
    let l:colors.yellow = ['#c49700', 172]
    let l:colors.blue = ['#0064e4', 26]
    let l:colors.magenta = ['#dd0f9d', 91]
    let l:colors.cyan = ['#00ad9c', 37]
    let l:colors.orange = ['#d04a00', 166]
    let l:colors.violet = ['#7f51d6', 98]

    let l:colors.br_red = ['#bf0000', 124]
    let l:colors.br_green = ['#008400', 28]
    let l:colors.br_yellow = ['#af8500', 136]
    let l:colors.br_blue = ['#0054cf', 26]
    let l:colors.br_magenta = ['#c7008b', 162]
    let l:colors.br_cyan = ['#009a8a', 30]
    let l:colors.br_orange = ['#ba3700', 130]
    let l:colors.br_violet = ['#6b40c3', 61]

    " Base background color.
    let l:colors.base = l:colors.bg_1

    " Pseudo transparency colors.
    let l:colors.blend_error = ['#f2cccc', 'NONE']
    let l:colors.blend_hint = ['#ccddf5', 'NONE']
    let l:colors.blend_info = ['#efe7cc', 'NONE']
    let l:colors.blend_warn = ['#f1d7cc', 'NONE']
    let l:colors.blend_added = ['#e8f4e5', 'NONE']
    let l:colors.blend_modified = ['#f9f4e5', 'NONE']
    let l:colors.blend_removed = ['#fbe5e6', 'NONE']
    let l:colors.blend_search = ['#d9cca4', 'NONE']
  endif

  " Get Enfocado style.
  let g:enfocado_style = get(g:, 'enfocado_style', 'nature')

  " Style colors.
  if g:enfocado_style ==# 'nature'
    " Nature accent colors.
    let l:colors.accent_0 = l:colors.green
    let l:colors.accent_1 = l:colors.blue
    let l:colors.br_accent_0 = l:colors.br_green
    let l:colors.br_accent_1 = l:colors.br_blue

    " Nature builtin colors (neon colors).
    let l:colors.builtin_0 = l:colors.magenta
    let l:colors.builtin_1 = l:colors.violet
    let l:colors.br_builtin_0 = l:colors.br_magenta
    let l:colors.br_builtin_1 = l:colors.br_violet
  else
    " Neon accent colors.
    let l:colors.accent_0 = l:colors.magenta
    let l:colors.accent_1 = l:colors.violet
    let l:colors.br_accent_0 = l:colors.br_magenta
    let l:colors.br_accent_1 = l:colors.br_violet

    " Neon builtin colors (nature colors).
    let l:colors.builtin_0 = l:colors.green
    let l:colors.builtin_1 = l:colors.blue
    let l:colors.br_builtin_0 = l:colors.br_green
    let l:colors.br_builtin_1 = l:colors.br_blue
  endif

  " Colors return.
  return l:colors
endfunction

" A function is created to highlight the groups.
function s:hi(group, attr, bg, fg, sp)
  execute 'highlight! '.a:group . ' ' .
        \ 'cterm='.a:attr[1] . ' ' . 'gui='.a:attr[0] . ' ' .
        \ 'ctermbg='.a:bg[1] . ' ' . 'guibg='.a:bg[0] . ' ' .
        \ 'ctermfg='.a:fg[1] . ' ' . 'guifg='.a:fg[0] . ' ' .
        \ 'guisp='.a:sp[0]
endfunction

" Necessary variables are initialized.
let s:hasTermguicolors = has('termguicolors') ? 1 : 0
let s:hasGui_running = has('gui_running') ? 1 : 0

" The script ends if the theme is not supported.
if !s:hasGui_running
  set t_Co=256
endif

" Get the color scheme.
let s:colorScheme = s:get_colors()

" The color scheme to use are assigned.
let s:bg_0 = s:colorScheme.bg_0
let s:bg_1 = s:colorScheme.bg_1
let s:bg_2 = s:colorScheme.bg_2
let s:dim_0 = s:colorScheme.dim_0
let s:fg_0 = s:colorScheme.fg_0
let s:fg_1 = s:colorScheme.fg_1

let s:red = s:colorScheme.red
let s:green = s:colorScheme.green
let s:yellow = s:colorScheme.yellow
let s:blue = s:colorScheme.blue
let s:magenta = s:colorScheme.magenta
let s:cyan = s:colorScheme.cyan
let s:orange = s:colorScheme.orange
let s:violet = s:colorScheme.violet

let s:br_red = s:colorScheme.br_red
let s:br_green = s:colorScheme.br_green
let s:br_yellow = s:colorScheme.br_yellow
let s:br_blue = s:colorScheme.br_blue
let s:br_magenta = s:colorScheme.br_magenta
let s:br_cyan = s:colorScheme.br_cyan
let s:br_orange = s:colorScheme.br_orange
let s:br_violet = s:colorScheme.br_violet

let s:base = s:colorScheme.base

let s:blend_search = s:colorScheme.blend_search
let s:blend_error = s:colorScheme.blend_error
let s:blend_info = s:colorScheme.blend_info
let s:blend_hint = s:colorScheme.blend_hint
let s:blend_warn = s:colorScheme.blend_warn
let s:blend_added = s:colorScheme.blend_added
let s:blend_removed = s:colorScheme.blend_removed
let s:blend_modified = s:colorScheme.blend_modified

let s:accent_0 = s:colorScheme.accent_0
let s:accent_1 = s:colorScheme.accent_1
let s:br_accent_0 = s:colorScheme.br_accent_0
let s:br_accent_1 = s:colorScheme.br_accent_1

let s:builtin_0 = s:colorScheme.builtin_0
let s:builtin_1 = s:colorScheme.builtin_1
let s:br_builtin_0 = s:colorScheme.br_builtin_0
let s:br_builtin_1 = s:colorScheme.br_builtin_1

" Attributes are declared.
let s:none = ['NONE', 'NONE']
let s:nocombine = ['nocombine,NONE', 'nocombine,NONE']
let s:bold = ['nocombine,bold', 'nocombine,bold']
let s:italic = ['nocombine,italic', 'nocombine,italic']
let s:underline = ['underline', 'underline']
let s:undercurl = ['undercurl', 'undercurl']

" All highlights are removed.
unlet! g:colors_name
hi clear
if exists('syntax_on')
  syntax reset
endif

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
" SECTION: Neo(Vim) base groups highlighting.
" ------------------------------------------------------------------------------
" General interface.
call s:hi('IncSearch', s:none, s:br_yellow, s:bg_1, s:none)
call s:hi('Search', s:none, s:br_yellow, s:bg_1, s:none)
call s:hi('LineNr', s:none, s:none, s:dim_0, s:none)
call s:hi('Accent', s:none, s:none, s:br_accent_0, s:none)
call s:hi('Builtin', s:none, s:none, s:br_builtin_0, s:none)
call s:hi('ColorColumn', s:none, exists('$DISPLAY') ? s:bg_2 : ['#808080', 244], s:none, s:none)
call s:hi('Conceal', s:nocombine, s:none, s:bg_2, s:none)
call s:hi('Cursor', s:none, s:fg_0, s:bg_1, s:none)
call s:hi('CursorColumn', s:none, s:bg_1, s:none, s:none)
call s:hi('CursorLine', s:none, s:bg_1, s:none, s:none)
call s:hi('CursorLineNr', s:none, s:none, s:fg_0, s:none)
call s:hi('DiffAdd', s:none, s:none, s:green, s:none)
call s:hi('DiffChange', s:none, s:none, s:yellow, s:none)
call s:hi('DiffDelete', s:none, s:none, s:red, s:none)
call s:hi('DiffText', s:none, s:fg_0, s:bg_0, s:none)
call s:hi('Dimmed', s:nocombine, s:none, s:dim_0, s:none)
call s:hi('Directory', s:none, s:none, s:br_blue, s:none)
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
call s:hi('MatchParen', s:none, s:dim_0, s:none, s:none)
call s:hi('ModeMsg', s:nocombine, s:none, s:fg_0, s:none)
call s:hi('MoreMsg', s:nocombine, s:none, s:br_yellow, s:none)
call s:hi('None', s:none, s:none, s:none, s:none)
call s:hi('NonText', s:nocombine, s:none, s:bg_2, s:none)
call s:hi('Normal', s:nocombine, s:bg_0, s:fg_0, s:none)
call s:hi('NormalFloat', s:nocombine, s:bg_1, s:fg_0, s:none)
call s:hi('NvimInternalError', s:nocombine, s:none, s:br_red, s:none)
call s:hi('Pmenu', s:nocombine, s:bg_1, s:fg_0, s:none)
call s:hi('PmenuSbar', s:nocombine, s:bg_1, s:none, s:none)
call s:hi('PmenuSel', s:none, s:bg_2, s:none, s:none)
call s:hi('PmenuThumb', s:nocombine, s:bg_2, s:none, s:none)
call s:hi('Question', s:nocombine, s:none, s:br_yellow, s:none)
call s:hi('QuickFixLine', s:none, s:bg_1, s:br_accent_0, s:none)
call s:hi('RedrawDebugClear', s:none, s:none, s:br_yellow, s:none)
call s:hi('RedrawDebugComposed', s:none, s:none, s:br_green, s:none)
call s:hi('RedrawDebugNormal', s:none, s:none, s:fg_1, s:none)
call s:hi('RedrawDebugRecompose', s:none, s:none, s:br_red, s:none)
call s:hi('SignColumn', s:none, s:none, s:none, s:none)
call s:hi('SpecialKey', s:nocombine, s:none, s:bg_2, s:none)
call s:hi('SpellBad', s:underline, s:none, s:red, s:red)
call s:hi('SpellCap', s:underline, s:none, s:blue, s:blue)
call s:hi('SpellLocal', s:underline, s:none, s:cyan, s:cyan)
call s:hi('SpellRare', s:underline, s:none, s:magenta, s:magenta)
call s:hi('StatusLine', s:nocombine, s:bg_0, s:fg_0, s:none)
call s:hi('StatusLineNC', s:nocombine, s:bg_0, s:dim_0, s:none)
call s:hi('StatuslineTerm', s:nocombine, s:bg_1, s:dim_0, s:none)
call s:hi('StatuslineTermNC', s:nocombine, s:bg_1, s:bg_2, s:none)
call s:hi('Success', s:nocombine, s:none, s:br_green, s:none)
call s:hi('TabLine', s:nocombine, s:bg_1, s:bg_2, s:none)
call s:hi('TabLineFill', s:nocombine, s:bg_1, s:bg_2, s:none)
call s:hi('TabLineSel', s:nocombine, s:none, s:dim_0, s:none)
call s:hi('TermCursor', s:none, s:fg_0, s:bg_1, s:none)
call s:hi('Title', s:none, s:none, s:fg_1, s:none)
call s:hi('ToolbarButton', s:nocombine, s:accent_0, s:bg_1, s:none)
call s:hi('ToolbarLine', s:nocombine, s:bg_1, s:dim_0, s:none)
call s:hi('VertSplit', s:nocombine, s:none, s:dim_0, s:none)
call s:hi('Visual', s:none, exists('$DISPLAY') ? s:bg_2 : ['#808080', 244], s:none, s:none)
call s:hi('VisualNC', s:none, s:bg_1, s:none, s:none)
call s:hi('VisualNOS', s:none, exists('$DISPLAY') ? s:bg_2 : ['#808080', 244], s:none, s:none)
call s:hi('WarningMsg', s:nocombine, s:none, s:br_orange, s:none)
call s:hi('WildMenu', s:bold, s:bg_2, s:br_accent_0, s:none)
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
call s:hi('FunctionBuiltin', s:none, s:none, s:br_builtin_0, s:none)
call s:hi('Identifier', s:nocombine, s:none, s:accent_0, s:none)
call s:hi('IdentifierBuiltin', s:nocombine, s:none, s:builtin_0, s:none)
call s:hi('Link', s:none, s:none, s:br_cyan, s:br_cyan)
call s:hi('PreProc', s:nocombine, s:none, s:accent_1, s:none)
call s:hi('Special', s:nocombine, s:none, s:br_builtin_1, s:none)
call s:hi('Statement', s:nocombine, s:none, s:accent_1, s:none)
call s:hi('StatementBuiltin', s:nocombine, s:none, s:builtin_1, s:none)
call s:hi('String', s:nocombine, s:none, s:cyan, s:br_cyan)
call s:hi('Text', s:nocombine, s:none, s:fg_0, s:none)
call s:hi('Todo', s:bold, s:br_cyan, s:bg_1, s:none)
call s:hi('Type', s:none, s:none, s:br_accent_1, s:none)
call s:hi('TypeBuiltin', s:none, s:none, s:br_builtin_1, s:none)
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
  call s:hi('DiagnosticHint', s:none, s:none, s:br_blue, s:none)
  call s:hi('DiagnosticInfo', s:none, s:none, s:br_yellow, s:none)
  call s:hi('DiagnosticWarn', s:none, s:none, s:br_orange, s:none)
  call s:hi('DiagnosticFloatingError', s:none, s:bg_1, s:br_red, s:none)
  call s:hi('DiagnosticFloatingHint', s:none, s:bg_1, s:br_blue, s:none)
  call s:hi('DiagnosticFloatingInfo', s:none, s:bg_1, s:br_yellow, s:none)
  call s:hi('DiagnosticFloatingWarn', s:none, s:bg_1, s:br_orange, s:none)
  call s:hi('DiagnosticUnderlineError', s:undercurl, s:none, s:none, s:br_red)
  call s:hi('DiagnosticUnderlineHint', s:undercurl, s:none, s:none, s:br_blue)
  call s:hi('DiagnosticUnderlineInfo', s:undercurl, s:none, s:none, s:br_yellow)
  call s:hi('DiagnosticUnderlineWarn', s:undercurl, s:none, s:none, s:br_orange)
  if (s:hasTermguicolors && &termguicolors) || s:hasGui_running
    call s:hi('DiagnosticVirtualTextError', s:none, s:blend_error, s:br_red, s:none)
    call s:hi('DiagnosticVirtualTextHint', s:none, s:blend_hint, s:br_blue, s:none)
    call s:hi('DiagnosticVirtualTextInfo', s:none, s:blend_info, s:br_yellow, s:none)
    call s:hi('DiagnosticVirtualTextWarn', s:none, s:blend_warn, s:br_orange, s:none)
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

" Highlight blank line
" Ref: https://stackoverflow.com/a/706083
" Ref: https://stackoverflow.com/a/27897508
augroup highlight_blank_lines
  autocmd!
  autocmd VimEnter,WinEnter * match ColorColumn /^$/
augroup END

" vim-sneak
call s:hi('SneakLabel', s:none, s:base, ['#87ff87', 120], s:none)

" The Enfocado theme is initialized.
let g:colors_name = 'enfocadomod'