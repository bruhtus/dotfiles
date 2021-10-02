" there's also `cpoptions` to not set the read file as alternate file when
" using `:read`
function! template#python()
  if filereadable(expand('~/.config/nvim/templates/python'))
    -1read $HOME/.config/nvim/templates/python
    bw#
    bp
    bn
    norm! GkJx4kF(
  else
    echo "Python template doesn't exist"
  endif
endfunction

function! template#sh()
  if filereadable(expand('~/.config/nvim/templates/sh'))
    -1read $HOME/.config/nvim/templates/sh
    bw#
    bp
    bn
    norm! L
    filetype detect
  else
    echo "Shell script template doesn't exist"
  endif
endfunction

function! template#vim()
  if filereadable(expand('~/.config/nvim/templates/vim'))
    -1read $HOME/.config/nvim/templates/vim
    bw#
    bp
    bn
    norm! Lkf_
  else
    echo "Vim template doesn't exist"
  endif
endfunction
