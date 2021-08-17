setlocal makeprg=pdfroff\ -mspdf\ -t\ %\ \\\|\ zathura\ -

let maplocalleader = '\'

nnoremap <buffer> <localleader>\ :make<CR><CR>
nnoremap <buffer> <localleader>] :w! \| !pdfroff -mspdf -t % > %:r.pdf<CR><CR>
