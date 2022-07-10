" automatically load quickr-preview.vim plugin before opening
" quickfix/location list window
" automatically open location/quickfix window after running :make, :grep, etc
augroup location_quickfix_list
  autocmd!
  " close window if location/quickfix window is the only window left
  autocmd WinEnter * if winnr('$') == 1 && &buftype == 'quickfix' | q | endif
  autocmd QuickFixCmdPre [^l]*
        \ if !exists('g:quickr_preview_keymaps') |
        \   let g:quickr_preview_keymaps = 0     |
        \   packadd quickr-preview.vim           |
        \ endif
  autocmd QuickFixCmdPre l*
        \ if !exists('g:quickr_preview_keymaps') |
        \   let g:quickr_preview_keymaps = 0     |
        \   packadd quickr-preview.vim           |
        \ endif                                  |
  " autocmd QuickFixCmdPost [^l]* cwindow
  " autocmd QuickFixCmdPost l*    lwindow
augroup END
