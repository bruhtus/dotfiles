setlocal noignorecase spell complete+=kspell

let maplocalleader = '\'

" there's also built-in DiffGitCached from tpope vim-git
nnoremap <buffer> <silent> <localleader>\ :try <Bar> packadd committia.vim <Bar> call committia#open('git') <Bar> catch <Bar> DiffGitCached <Bar> endtry<CR>

augroup VimGit
  autocmd!
  autocmd FileType git
        \  nmap <buffer> <nowait> <Space> <C-d>
        \| nmap <buffer> <nowait> u <C-u>
augroup END
