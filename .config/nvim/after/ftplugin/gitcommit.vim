setlocal spell complete+=kspell

let maplocalleader = '\'

" there's also built-in DiffGitCached from tpope vim-git
nnoremap <buffer> <silent> <localleader>\
      \ :try <Bar>
      \   if !exists('g:loaded_committia') \| packadd committia.vim \| endif <Bar>
      \   call committia#open('git') <Bar>
      \ catch /^Vim\%((\a\+)\)\=:E117/ <Bar>
      \   DiffGitCached <Bar>
      \ endtry<CR>

augroup gitcommit
  autocmd!
  autocmd FileType git
        \  nmap <buffer> <nowait> <Space> <C-d>
        \| nmap <buffer> <nowait> u <C-u>
augroup END
