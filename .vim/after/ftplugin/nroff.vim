let b:groff_cmd = '!groff -Kutf8 -ms -Tpdf "%"'

let maplocalleader = '\'

nnoremap <buffer> <localleader>\ :exe b:groff_cmd . ' \| zathura -'<CR>:redraw!<CR>
nnoremap <buffer> <localleader>] :exe b:groff_cmd . ' > "%:r.pdf"'<CR>:redraw!<CR>
