setlocal makeprg=pdfroff\ -mspdf\ -t\ %\ \\\|\ zathura\ -

let maplocalleader = '\'

nnoremap <buffer> <localleader>\ :make<CR>:redraw!<CR>
nnoremap <buffer> <localleader>] :!pdfroff -mspdf -t % > %:r.pdf<CR>:redraw!<CR>
