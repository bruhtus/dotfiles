setlocal spell complete+=kspell

" let maplocalleader = '\'

" Ref: https://github.com/tpope/vim-git/blob/master/ftplugin/gitcommit.vim
" function! s:gitdiffcommit() abort
"   let name = tempname()
"   " Note: go back to git root directory
"   lcd ..
"   if !empty(system('git diff --cached --no-color --no-ext-diff'))
"     " Note: use the git diff in git root directory instead of .git directory
"     call system('git diff --cached --no-color --no-ext-diff > ' . shellescape(name))
"     let previewheight = &previewheight
"     " Note: half the current window height (only when initialization, not
"     " dynamic)
"     let &previewheight = winheight(0) / 2
"     exe 'pedit ' . fnameescape(name)
"     wincmd P
"     nnoremap <buffer> <silent> <nowait> q :<C-u>bw<CR>
"     setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile nomodifiable filetype=git
"     let &previewheight = previewheight
"     " Note: move preview window to the right if window width more than 160
"     if winwidth(0) > 160 | wincmd H | endif
"     wincmd p
"   else
"     echo 'No output from git diff --cached'
"   endif
" endfunction

" nnoremap <expr> <buffer> <silent> <localleader>\
"       \ &filetype ==# 'gitcommit' && empty(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") ==# "git"')) ?
"       \ ':<C-u>call <SID>gitdiffcommit()<CR>' :
"       \ ':<C-u>$bw<CR>'

" augroup gitcommit
"   autocmd!
"   " autocmd FileType git
"   "       \  nmap <buffer> <nowait> <Space> <C-d>
"   "       \| nmap <buffer> <nowait> u <C-u>
"   " autocmd VimEnter COMMIT_EDITMSG call <SID>gitdiffcommit()
"   autocmd WinEnter * if winnr('$') == 1 && &filetype == 'git' | q | endif
" augroup END

" there's also built-in DiffGitCached from tpope vim-git
" nnoremap <buffer> <silent> <localleader>\
"       \ :try <Bar>
"       \   if !exists('g:loaded_committia') \| packadd committia.vim \| endif <Bar>
"       \   call committia#open('git') <Bar>
"       \ catch /^Vim\%((\a\+)\)\=:E117/ <Bar>
"       \   DiffGitCached <Bar>
"       \ endtry<CR>
