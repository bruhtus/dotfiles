setlocal makeprg=pdfroff\ -mspdf\ -t\ %\ \\\|\ zathura\ -

let maplocalleader = '\'

nnoremap <buffer> <localleader>\ :silent! make<CR>
nnoremap <buffer> <localleader>[ :w! \| !pdfroff -mspdf -t % > %:r.pdf<CR><CR>
