" automatically open location/quickfix window after running :make, :grep, etc
augroup location_quickfix_list
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" close window if location/quickfix window is the only window left
augroup QFClose
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
augroup END
