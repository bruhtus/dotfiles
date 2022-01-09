" Ref:
" https://github.com/tpope/vim-sleuth/commit/bb6a50779c7787e3b6d46e80d4659481ae0bac4f
" Discussion: https://github.com/vim/vim/issues/2286
" Note: seems like findfile() can be expensive on remote server? we'll see
" how that goes.
" Bram Opinion About Editorconfig:
" https://github.com/vim/vim/issues/2286#issuecomment-484619734
" Opinion About Remote Files:
" https://github.com/vim/vim/issues/2286#issuecomment-487651664
function! editorconfig#indent(file)
  let l:path = fnamemodify(a:file, ':p')
  let l:lines = readfile(l:path)

  for line in l:lines
    if line !~# '\v(^indent_style*|^indent_size*|^tab_width*)'
      continue
    elseif line =~# '^indent_style*'
      let b:editorconfig_indent_style = split(line)[2]
    elseif line =~# '^indent_size*'
      let b:editorconfig_indent_size = split(line)[2]
    elseif line =~# '^tab_width*'
      let b:editorconfig_tab_width = split(line)[2]
    endif
  endfor

  " Note: is there a case that someone set indent_size and tab_width but not
  " indent_style?
  if exists('b:editorconfig_indent_style')
    if b:editorconfig_indent_style == 'tab'
      if exists('b:editorconfig_tab_width')
        let [&l:ts, &l:et] = [b:editorconfig_tab_width, 0]
      elseif exists('b:editorconfig_indent_size')
        let [&l:ts, &l:et] = [b:editorconfig_indent_size, 0]
      endif
    elseif b:editorconfig_indent_style == 'space'
      if exists('b:editorconfig_indent_size')
        " Ref: :h type()
        if b:editorconfig_indent_size == 'tab'
          if exists('b:editorconfig_tab_width')
            let [&l:sw, &l:et] = [b:editorconfig_tab_width, 1]
          endif
        else
          let [&l:sw, &l:et] = [b:editorconfig_indent_size, 1]
        endif
      endif
    endif
  endif
endfunction
