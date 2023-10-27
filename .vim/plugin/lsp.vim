function! IDE() abort
  " Ref: https://github.com/prabirshrestha/vim-lsp/issues/596
  if !exists('g:lsp_loaded')
    let g:lsp_auto_enable = 0
    let g:lsp_document_code_action_signs_enabled = 0
    let g:lsp_settings_enable_suggestions = 0
    let g:lsp_diagnostics_echo_cursor = 0
    let g:lsp_diagnostics_echo_delay = 1
    let g:lsp_signature_help_enabled = 0
    let g:lsp_document_highlight_enabled = 0
    let g:lsp_diagnostics_virtual_text_enabled = 0
    let g:lsp_fold_enabled = 0
    let g:lsp_float_max_width = winwidth(0)
    " let g:lsp_diagnostics_float_cursor = 1
    " let g:lsp_diagnostics_float_delay = 1
    " let g:lsp_log_file = expand('~/.vim/lsp.log')
    packadd vim-lsp

    augroup lsp_init
      autocmd!
      autocmd User lsp_buffer_enabled call vimlsp#init()
    augroup END
  endif

  if !exists('g:loaded_lsp_settings')
    packadd vim-lsp-settings

    if exists('*lsp_settings#utils#group_name')
      if exists('#' . lsp_settings#utils#group_name(&ft) . '#FileType#' . &ft)
        exe 'doautocmd <nomodeline>' lsp_settings#utils#group_name(&ft) 'FileType' &ft
      endif
    endif
  endif

  " if !exists('g:loaded_neoformat')
  "   let g:neoformat_try_node_exe = 1
  "   " let g:neoformat_run_all_formatters = 1
  "   let g:neoformat_enabled_javascript = ['prettier']
  "   let g:neoformat_enabled_html = ['prettier']
  "   let g:neoformat_enabled_markdown = []
  "   packadd neoformat
  "   autocmd lsp_init BufWritePre *
  "         \ if !exists('g:no_formatter') && exists(':Neoformat') |
  "         \   silent Neoformat |
  "         \ endif
  " endif

  if exists('g:lsp_enabled')
    unlet g:lsp_enabled
    call lsp#disable()
    LspStopServer
  else
    let g:lsp_enabled = 1
    call lsp#enable()
  endif
endfunction

" toggle lsp
nnoremap <silent> <leader>q :<C-u>call IDE()<CR>

let g:lsp_filetype = [
      \   'typescript',
      \   'typescriptreact',
      \   'javascript',
      \   'dart',
      \   'terraform',
      \ ]

augroup lazy_load_lsp
  autocmd!

  if has('patch-8.1.1113')
    exe 'autocmd FileType \v(' . join(g:lsp_filetype, '|') . ') ++once'
          \ . ' call IDE() | augroup! lazy_load_lsp'
  else
    exe 'autocmd FileType \v(' . join(g:lsp_filetype, '|') . ')'
          \ . ' call IDE() | autocmd! lazy_load_lsp FileType | augroup! lazy_load_lsp'
  endif
augroup END

" let s:lsp_server_dir = $HOME . '/.local/share/vim-lsp-settings/servers/typescript-language-server'

" if executable(s:lsp_server_dir . '/typescript-language-server')
"   autocmd User lsp_setup call lsp#register_server({
"         \ 'name': 'typescript-language-server'
"         \ ,'cmd': {server_info->[
"         \   &shell,
"         \   &shellcmdflag,
"         \   s:lsp_server_dir . '/typescript-language-server --stdio',
"         \ ]}
"         \ ,'root_uri': {
"         \   server_info->lsp#utils#path_to_uri(
"         \     lsp#utils#find_nearest_parent_file_directory(
"         \       lsp#utils#get_buffer_path(),
"         \       ['package.json', '.git/']
"         \     )
"         \   )
"         \ }
"         \ ,'allowlist': ['typescript']
"         \ ,'blocklist': []
"         \ ,'initialization_options': {
"         \   'preferences': {
"         \     'includeInlayParameterNameHintsWhenArgumentMatchesName': v:true,
"         \     'includeInlayParameterNameHints': 'all',
"         \     'includeInlayVariableTypeHints': v:true,
"         \     'includeInlayPropertyDeclarationTypeHints': v:true,
"         \     'includeInlayFunctionParameterTypeHints': v:true,
"         \     'includeInlayEnumMemberValueHints': v:true,
"         \     'includeInlayFunctionLikeReturnTypeHints': v:true
"         \   }
"         \ }
"         \ })
" endif
