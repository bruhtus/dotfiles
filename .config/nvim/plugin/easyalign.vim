" Start interactive EasyAlign for a motion/text object (e.g. glip)
" Also add current line to jumplist before execute EasyAlign
nmap <expr> <silent> gl (!exists('g:loaded_easy_align_plugin') ? "m':<C-u>packadd vim-easy-align<CR>" : "m'" ) . '<Plug>(EasyAlign)'

" Start interactive EasyAlign in visual mode (e.g. vipgl)
" Also add current line to jumplist before execute EasyAlign
xmap <expr> <silent> gl (!exists('g:loaded_easy_align_plugin') ? "m':<C-u>packadd vim-easy-align <Bar> norm! gv<CR>" : "m'" ) . '<Plug>(EasyAlign)'
