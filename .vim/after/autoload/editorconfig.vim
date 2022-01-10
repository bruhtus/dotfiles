" Ref: https://editorconfig.org/#file-format-details
" Ref:
" https://github.com/tpope/vim-sleuth/commit/bb6a50779c7787e3b6d46e80d4659481ae0bac4f
" Discussion: https://github.com/vim/vim/issues/2286
" Note: seems like findfile() can be expensive on remote server? we'll see
" how that goes.
" Bram Opinion About Editorconfig:
" https://github.com/vim/vim/issues/2286#issuecomment-484619734
" Opinion About Remote Files:
" https://github.com/vim/vim/issues/2286#issuecomment-487651664
" Alternative: https://github.com/vim/vim/issues/2286#issuecomment-484794784
function! editorconfig#indent(file) abort
  let l:path = fnamemodify(a:file, ':p')
  let l:lines = readfile(l:path)

  let b:editorconfig_section = []
  let b:editorconfig_indent_style = []
  let b:editorconfig_indent_size = []
  let b:editorconfig_tab_width = []

  " Output: [['[*]', '2'], ['[markdown]', '4']]
  for line in l:lines
    if line !~? '\v(^\[*.*\]|^indent_style*|^indent_size*|^tab_width*)'
      continue
    " Note: for editorconfig section.
    elseif line =~? '^\[*.*\]'
      call extend(b:editorconfig_section, [line])
    elseif line =~? '^indent_style*'
      call extend(b:editorconfig_indent_style,
            \ [[b:editorconfig_section[-1:][0], split(line)[2]]]
            \ )
    elseif line =~? '^indent_size*'
      call extend(b:editorconfig_indent_size,
            \ [[b:editorconfig_section[-1:][0], split(line)[2]]]
            \ )
    elseif line =~? '^tab_width*'
      call extend(b:editorconfig_tab_width,
            \ [[b:editorconfig_section[-1:][0], split(line)[2]]]
            \ )
    endif
  endfor

  " Note: we need to have at least [*] section right?
  " Ref:
  " https://github.com/sindresorhus/atom-editorconfig/issues/209#issuecomment-353128613
  if len(b:editorconfig_section) != 0
    for section in b:editorconfig_section
      " Note: is there a case that someone set indent_size and tab_width but
      " not indent_style?
      if len(b:editorconfig_indent_style) != 0
        for l:indent_style in b:editorconfig_indent_style
          if l:indent_style[0] == '[*]'
            call s:indent_init(l:indent_style[0], l:indent_style[1])
          else
            " Output: markdown, *.md
            let l:section_indent =
                  \ substitute(l:indent_style[0], '\v(\[|\])', '', 'g')

            " Output:
            " autocmd indent_detection BufNewFile,BufRead *.md call
            " s:indent_init('[*.md]', 'space')
            " Note: still only works for glob pattern.
            " TODO: figure out a way to make this work with other editorconfig
            " wildcard patterns.
            " Note: only initialize autocmd once.
            if !exists('#indent_detection#BufNewFile#' . l:section_indent)
                  \ && !exists('#indent_detection#BufRead#' . l:section_indent)
              execute 'autocmd indent_detection BufNewFile,BufRead '
                    \ . l:section_indent
                    \ . ' call s:indent_init('
                    \ . "'" . l:indent_style[0] . "'" . ', '
                    \ . "'" . l:indent_style[1] . "'" . ')'
            endif

          endif
        endfor
      endif
    endfor
  endif
endfunction

function! s:indent_init(section, style) abort
  if a:style ==? 'tab'
    let l:save_et = &et
    " Note: this is indicator that tab_width doesn't exist, in
    " hope that indent_size exist and overwrite this option.
    let &et = 1

    for l:tab_width in b:editorconfig_tab_width
      if l:tab_width[0] == a:section
        let [&ts, &et] = [l:tab_width[1], 0]
      endif
    endfor

    if &et
      for l:indent_size in b:editorconfig_indent_size
        if l:indent_size[0] == a:section
          " Note: in case someone drunk and provide indent_style as
          " tab but didn't provide tab_width, and also, to make
          " things worse, provide indent_size as tab.
          if l:indent_size[1] !=? 'tab'
            let [&ts, &et] = [l:indent_size[1], 0]
          endif
        endif
      endfor
      " Note: this is indicator that indent_size also doesn't exist.
      " feeling hopeless, going back to previous expandtab value.
      if &et | let &et = l:save_et | endif
    endif

  elseif a:style ==? 'space'
    for l:indent_size in b:editorconfig_indent_size
      if l:indent_size[0] == a:section
        if l:indent_size[1] ==? 'tab'
          for l:tab_width in b:editorconfig_tab_width
            if l:tab_width[0] == a:section
              let [&sw, &et] = [l:tab_width[1], 1]
            endif
          endfor
        else
          let [&sw, &et] = [l:indent_size[1], 1]
        endif
      endif
    endfor
  endif
endfunction
