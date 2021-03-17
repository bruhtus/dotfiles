" vim-easymotion plugin config and mapping

let g:EasyMotion_do_mapping = 0

" easymotion target colorscheme
hi EasyMotionTarget ctermbg=none ctermfg=lightgreen
hi EasyMotionTarget2First ctermbg=none ctermfg=lightred
hi EasyMotionTarget2Second ctermbg=none ctermfg=red

map  <leader>k <Plug>(easymotion-bd-w)
