" Start interactive EasyAlign for a motion/text object (e.g. glip)
" Also add current line to jumplist before execute EasyAlign
nmap <silent> gl m':<C-u>packadd vim-easy-align<CR><Plug>(EasyAlign)

" Start interactive EasyAlign in visual mode (e.g. vipgl)
" Also add current line to jumplist before execute EasyAlign
xmap <silent> gl m':<C-u>packadd vim-easy-align<CR>gv<Plug>(EasyAlign)
