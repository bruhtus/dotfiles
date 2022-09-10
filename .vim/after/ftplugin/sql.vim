if exists('$DOCKER_POSTGRES_DB')
  let g:db = $DOCKER_POSTGRES_DB
endif

packadd vim-dadbod
packadd vim-dadbod-completion

setlocal omnifunc=vim_dadbod_completion#omni
