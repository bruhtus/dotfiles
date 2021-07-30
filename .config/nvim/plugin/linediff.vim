command! -range -bar Linediff
      \ packadd linediff.vim                              |
      \ let g:linediff_buffer_type            = 'scratch' |
      \ let g:linediff_first_buffer_command   = 'enew'    |
      \ let g:linediff_further_buffer_command = 'new'     |
      \ Linediff
