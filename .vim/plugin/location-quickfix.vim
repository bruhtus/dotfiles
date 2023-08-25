" automatically load quickr-preview.vim plugin before opening
" quickfix/location list window
" automatically open location/quickfix window after running :make, :grep, etc

" another alternative to `:Cfilter` and `Lfilter`:
" https://github.com/TamaMcGlinn/quickfixdd
augroup location_quickfix_list
  autocmd!
  " close window if location/quickfix window is the only window left
  autocmd WinEnter * if winnr('$') == 1 && &buftype == 'quickfix' | q | endif

  autocmd QuickFixCmdPre [^l]*
        \ if !exists('g:quickr_preview_keymaps') |
        \   let g:quickr_preview_keymaps = 0 |
        \   packadd quickr-preview.vim |
        \ endif |
        \ if has('patch-8.1.0649') && exists(':Cfilter') != 2 |
        \   packadd cfilter |
        \ endif

  autocmd QuickFixCmdPre l*
        \ if !exists('g:quickr_preview_keymaps') |
        \   let g:quickr_preview_keymaps = 0 |
        \   packadd quickr-preview.vim |
        \ endif |
        \ if has('patch-8.1.0649') && exists(':Lfilter') != 2 |
        \   packadd cfilter |
        \ endif

  " autocmd QuickFixCmdPost [^l]* cwindow
  " autocmd QuickFixCmdPost l*    lwindow
augroup END
