function! template#python()
  if filereadable(expand('~/.config/nvim/templates/python'))
    -1read $HOME/.config/nvim/templates/python
    norm GkJx4kF(
  else
    echo "Python template doesn't exist"
  endif
endfunction

function! template#sh()
  if filereadable(expand('~/.config/nvim/templates/sh'))
    -1read $HOME/.config/nvim/templates/sh
    norm L
    filetype detect
  else
    echo "Shell script template doesn't exist"
  endif
endfunction
