" Ref: https://editorconfig.org/#file-format-details
" Discussion: https://github.com/vim/vim/issues/2286
" Note: seems like findfile() can be expensive on remote server? we'll see
" how that goes.
" Bram Opinion About Editorconfig:
" https://github.com/vim/vim/issues/2286#issuecomment-484619734
" Opinion About Remote Files:
" https://github.com/vim/vim/issues/2286#issuecomment-487651664
" Alternative: https://github.com/vim/vim/issues/2286#issuecomment-484794784

" Credit: https://github.com/tpope/vim-sleuth/blob/master/plugin/sleuth.vim
let s:fnmatch_replacements = {
      \ '.': '\.', '\%': '%', '\(': '(', '\)': ')', '\{': '{', '\}': '}', '\_': '_',
      \ '?': '[^/]', '*': '[^/]*', '/**/*': '/.*', '/**/': '/\%(.*/\)\=', '**': '.*'}

function! s:fnmatch_replace(pat) abort
  if has_key(s:fnmatch_replacements, a:pat)
    return s:fnmatch_replacements[a:pat]
  elseif len(a:pat) ==# 1
    return '\' . a:pat
  elseif a:pat =~# '^{[+-]\=\d\+\.\.[+-]\=\d\+}$'
    return '\%(' . join(range(matchstr(a:pat, '[+-]\=\d\+'), matchstr(a:pat, '\.\.\zs[+-]\=\d\+')), '\|') . '\)'
  elseif a:pat =~# '^{.*\\\@<!\%(\\\\\)*,.*}$'
    return '\%(' . substitute(a:pat[1:-2], ',\|\%(\\.\|{[^\{}]*}\|[^,]\)*', '\=submatch(0) ==# "," ? "\\|" : s:fnmatch_translate(submatch(0))', 'g') . '\)'
  elseif a:pat =~# '^{.*}$'
    return '{' . s:fnmatch_translate(a:pat[1:-2]) . '}'
  elseif a:pat =~# '^\[!'
    return '[^' . a:pat[2:-1]
  else
    return a:pat
  endif
endfunction

function! s:fnmatch_translate(pat) abort
  return substitute(a:pat, '\\.\|/\*\*/\*\=\|\*\*\=\|\[[!^]\=\]\=[^]/]*\]\|{\%(\\.\|[^{}]\|{[^\{}]*}\)*}\|[?.\~^$[]', '\=s:fnmatch_replace(submatch(0))', 'g')
endfunction

function! s:read_editorconfig(absolute_path) abort
  let l:lines = readfile(a:absolute_path)
  let l:prefix = '\m\C^' . escape(fnamemodify(a:absolute_path, ':h'), '][^$.*\~')
  let l:preamble = {}
  let l:pairs = l:preamble
  let l:sections = []

  for line in l:lines
    let l:line = substitute(line, '^[[:space:]]*\|[[:space:]]*\%([^[:space:]]\@<![;#].*\)\=$', '', 'g')
    let l:match = matchlist(line, '^\%(\[\(\%(\\.\|[^\;#]\)*\)\]\|\([^[:space:]]\@=[^;#=:]*[^;#=:[:space:]]\)[[:space:]]*[=:][[:space:]]*\(.*\)\)$')
    if len(get(l:match, 2, ''))
      let pairs[tolower(l:match[2])] = [l:match[3], a:absolute_path]
    elseif len(get(l:match, 1, '')) && len(get(l:match, 1, '')) <= 4096
      if l:match[1] =~# '^/'
        let l:pattern = l:match[1]
      elseif l:match[1] =~# '/'
        let l:pattern = '/' . l:match[1]
      else
        let l:pattern = '/**/' . l:match[1]
      endif
      let pairs = {}
      call add(l:sections, [prefix . s:fnmatch_translate(l:pattern) . '$', pairs])
    endif
  endfor

  return [l:preamble, l:sections]
endfunction

function! s:config(absolute_path) abort
  if empty(a:absolute_path)
    return [{}, '']
  endif

  let l:sections = []
  let l:read_config = s:read_editorconfig(a:absolute_path)

  call extend(l:sections, l:read_config[1], 'keep')
  if get(l:read_config[0], 'root', [''])[0] ==? 'true'
    let l:root = fnamemodify(get(l:read_config[0], 'root')[1], ':h')
  else
    let l:root = ''
  endif

  let l:config = {}
  call extend(l:config, {'root': [l:root]})
  for [pattern, pairs] in l:sections
    if expand('%:p') =~# pattern
      call extend(l:config, pairs)
    endif
  endfor

  return l:config
endfunction

function! editorconfig#init(absolute_path) abort
  let l:config = s:config(a:absolute_path)
  let l:pairs = map(copy(l:config), 'v:val[0]')

  if get(l:pairs, 'indent_style', '') ==? 'tab'
    let &et = 0
  elseif get(l:pairs, 'indent_style', '') ==? 'space'
    let &et = 1
  endif

  " Note:
  " in case someone drunk and provide indent_style as tab but didn't provide
  " tab_width, and also, to make things worse, provide indent_size as tab.
  if get(l:pairs, 'indent_size', '') =~? '^tab$' && has_key(l:pairs, 'tab_width')
    let &sw = l:pairs.tab_width
  elseif get(l:pairs, 'indent_size', '') =~? '^[1-9]\d*$'
    let &sw = l:pairs.indent_size
  endif

  if get(l:pairs, 'tab_width', '') =~? '^[1-9]\d*$'
    let [&ts, &et] = [l:pairs.tab_width, 0]
  endif
endfunction

" function! editorconfig#indent(file) abort
"   let l:path = fnamemodify(a:file, ':p')
"   let l:lines = readfile(l:path)

"   let b:editorconfig_section = []
"   let b:editorconfig_indent_style = []
"   let b:editorconfig_indent_size = []
"   let b:editorconfig_tab_width = []

"   " Output: [['[*]', '2'], ['[*.md]', '4']]
"   for line in l:lines
"     if line !~? '\v(^\[*.*\]|^indent_style*|^indent_size*|^tab_width*)'
"       continue
"     elseif line =~? '^\[*.*\]'
"       call extend(b:editorconfig_section, [line])
"     elseif line =~? '^indent_style*'
"       call extend(b:editorconfig_indent_style,
"             \ [[b:editorconfig_section[-1:][0], split(line)[2]]]
"             \ )
"     elseif line =~? '^indent_size*'
"       call extend(b:editorconfig_indent_size,
"             \ [[b:editorconfig_section[-1:][0], split(line)[2]]]
"             \ )
"     elseif line =~? '^tab_width*'
"       call extend(b:editorconfig_tab_width,
"             \ [[b:editorconfig_section[-1:][0], split(line)[2]]]
"             \ )
"     endif
"   endfor

"   " Note: we need to have at least [*] section right?
"   " Ref:
"   " https://github.com/sindresorhus/atom-editorconfig/issues/209#issuecomment-353128613
"   if len(b:editorconfig_section) != 0
"     for section in b:editorconfig_section
"       " Note: is there a case that someone set indent_size and tab_width but
"       " not indent_style?
"       if len(b:editorconfig_indent_style) != 0
"         for l:indent_style in b:editorconfig_indent_style
"           if l:indent_style[0] == '[*]'
"             call s:indent_init(l:indent_style[0], l:indent_style[1])
"           else
"             " Output: markdown, *.md
"             " let l:section_indent =
"             "       \ substitute(l:indent_style[0], '\v(\[|\])', '', 'g')

"             " Output:
"             " autocmd indent_detection BufNewFile,BufRead *.md
"             " if !empty(b:editorconfig_file) |
"             " call s:indent_init('[*.md]', 'space') | endif
"             " Note: still only works for glob pattern.
"             " TODO: figure out a way to make this work with other editorconfig
"             " wildcard patterns.
"             " Note: only initialize autocmd once.
"             " if !exists('#indent_detection#BufNewFile#' . l:section_indent)
"             "       \ && !exists('#indent_detection#BufRead#' . l:section_indent)
"             "   execute 'autocmd indent_detection BufNewFile,BufRead '
"             "         \ . l:section_indent
"             "         \ . ' if !empty(b:editorconfig_file) | call s:indent_init('
"             "         \ . "'" . l:indent_style[0] . "'" . ', '
"             "         \ . "'" . l:indent_style[1] . "'" . ') | endif'
"             " endif

"           endif
"         endfor
"       endif
"     endfor
"   endif
" endfunction

" function! s:indent_init(section, style) abort
"   if a:style ==? 'tab'
"     let l:save_et = &et
"     " Note: this is indicator that tab_width doesn't exist, in
"     " hope that indent_size exist and overwrite this option.
"     let &et = 1

"     for l:tab_width in b:editorconfig_tab_width
"       if l:tab_width[0] == a:section
"         let [&ts, &et] = [l:tab_width[1], 0]
"       endif
"     endfor

"     if &et
"       for l:indent_size in b:editorconfig_indent_size
"         if l:indent_size[0] == a:section
"           if l:indent_size[1] !=? 'tab'
"             let [&ts, &et] = [l:indent_size[1], 0]
"           endif
"         endif
"       endfor
"       " Note: this is indicator that indent_size also doesn't exist.
"       " feeling hopeless, going back to previous expandtab value.
"       if &et | let &et = l:save_et | endif
"     endif

"   elseif a:style ==? 'space'
"     for l:indent_size in b:editorconfig_indent_size
"       if l:indent_size[0] == a:section
"         if l:indent_size[1] ==? 'tab'
"           for l:tab_width in b:editorconfig_tab_width
"             if l:tab_width[0] == a:section
"               let [&sw, &et] = [l:tab_width[1], 1]
"             endif
"           endfor
"         else
"           let [&sw, &et] = [l:indent_size[1], 1]
"         endif
"       endif
"     endfor
"   endif
" endfunction
