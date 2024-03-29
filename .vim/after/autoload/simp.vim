" list, change, or delete buffer
function! simp#buf()
  let l:choice = confirm("List/Change/Delete Buffer(s)?",
        \ "&LList\n&JChange\n&KDelete\n&NCancel", 4)

  if l:choice == 1
    echo 'List buffer(s)'
    ls

  elseif l:choice == 2
    echo 'Change buffer'
    ls
    call inputsave()
    let l:buffernumber = input('Enter buffer number: ')
    call inputrestore()
    try
      if !empty(l:buffernumber)
        call execute("b " . l:buffernumber)
      endif
    catch
      redraw
      echo "Buffer doesn't exist"
    endtry

  elseif l:choice == 3
    echo 'Delete buffer(s)'
    ls
    call inputsave()
    let l:buffernumber = input('Enter buffer number: ')
    call inputrestore()
    try
      if !empty(l:buffernumber)
        call execute("bd " . l:buffernumber)
      endif
    catch
      redraw
      echo "Buffer doesn't exist"
    endtry

  elseif l:choice == 4
    " do nothing

  endif
endfunction

let g:markslist = '\"' . "'.0abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

function! simp#delmark()
  " only display mark [a-zA-Z], mark ', and mark .
  exe 'marks ' . g:markslist
  echo 'Mark: '

  " getchar() - prompts user for a single character and returns the chars
  " ascii representation
  " nr2char() - converts ASCII `NUMBER TO CHAR'

  let l:mark = nr2char(getchar())
  " remove the `press any key prompt'
  redraw

  " build a string which uses the `normal' command plus the var holding the
  " mark - then eval it.
  execute 'silent! delm ' . l:mark
endfunction

function! simp#addmark()
  " only display mark [a-zA-Z], mark ', and mark .
  exe 'marks ' . g:markslist
  echo 'Mark: '

  " getchar() - prompts user for a single character and returns the chars
  " ascii representation
  " nr2char() - converts ASCII `NUMBER TO CHAR'

  let l:mark = nr2char(getchar())
  " remove the `press any key prompt'
  redraw

  " build a string which uses the `normal' command plus the var holding the
  " mark - then eval it.
  try
    execute 'normal! m' . l:mark
  catch
  endtry
endfunction

function! simp#gotomark()
  " only display mark [a-zA-Z], mark ', and mark .
  exe 'marks ' . g:markslist
  echo 'Mark: '

  " getchar() - prompts user for a single character and returns the chars
  " ascii representation
  " nr2char() - converts ASCII `NUMBER TO CHAR'

  let l:mark = nr2char(getchar())
  " remove the `press any key prompt'
  redraw

  " build a string which uses the `normal' command plus the var holding the
  " mark - then eval it.
  try
    execute 'normal! `' . l:mark
    norm! zz
  catch
  endtry
endfunction

" horisontal or vertical split buffer
function! simp#split()
  let l:choice = confirm("Horizontal or Vertical Split Buffer?",
        \ "&JHorizontal\n&KVertical\n&NCancel", 3)

  if l:choice == 1
    echo 'Horizontal split'
    ls
    call inputsave()
    let l:buffernumber = input('Enter buffer number: ')
    call inputrestore()
    try
      if !empty(l:buffernumber)
        call execute("sb " . l:buffernumber)
      endif
    catch
    endtry

  elseif l:choice == 2
    echo 'Vertical split'
    ls
    call inputsave()
    let l:buffernumber = input('Enter buffer number: ')
    call inputrestore()
    try
      if !empty(l:buffernumber)
        call execute("vert sb " . l:buffernumber)
      endif
    catch
    endtry

  elseif l:choice == 3
    " do nothing

  endif
endfunction
