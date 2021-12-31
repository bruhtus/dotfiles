" there's also `cpoptions` to not set the read file as alternate file when
" using `:read`

let g:template_path =
      \ isdirectory(expand('~/.vim/templates')) ?
      \ '~/.vim/templates' :
      \ has('nvim-0.3.1') ?
      \ stdpath('config') . '/templates' :
      \ '~/.config/nvim/templates'

function! template#python()
  if filereadable(expand(g:template_path . '/python'))
    exe '-1read ' . g:template_path . '/python'
    bw#
    bp
    bn
    $d_
    call search('`CURSOR`', 'ebW')
    " Ref: https://stackoverflow.com/q/26223100
    let @/ = '`CURSOR`'
  else
    echo "Python template doesn't exist"
  endif
endfunction

function! template#sh()
  if filereadable(expand(g:template_path . '/sh'))
    exe '-1read ' . g:template_path . '/sh'
    bw#
    bp
    bn
    filetype detect
  else
    echo "Shell script template doesn't exist"
  endif
endfunction

function! template#vim()
  if filereadable(expand(g:template_path . '/vim'))
    exe '-1read ' . g:template_path . '/vim'
    bw#
    bp
    bn
    call search('`CURSOR`', 'eW')
    let @/ = '`CURSOR`'
  else
    echo "Vim template doesn't exist"
  endif
endfunction
