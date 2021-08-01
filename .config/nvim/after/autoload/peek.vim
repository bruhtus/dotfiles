function! peek#load()
  norm m`
  call inputsave()
  let l:linenumber = input('Enter line number: ')
  call inputrestore()
  " remove annoying Enter line number
  redraw
  " do nothing if the line number doesn't exist
  " don't be stupid
  try
    execute l:linenumber . "p"
  catch
  endtry
  norm ``
endfunction
