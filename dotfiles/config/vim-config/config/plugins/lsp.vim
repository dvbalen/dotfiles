let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_semantic_enabled = 1

if executable('basedpyright-langserver')
  augroup VimConfigBasedPyright
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'basedpyright',
          \ 'cmd': {server_info -> ['basedpyright-langserver', '--stdio']},
          \ 'root_uri': {server_info -> lsp#utils#path_to_uri(
          \   lsp#utils#find_nearest_parent_file_directory(
          \     lsp#utils#get_buffer_path(),
          \     ['pyproject.toml', 'setup.cfg', 'setup.py', '.git/']))},
          \ 'allowlist': ['python'],
          \ })
  augroup END
elseif executable('pyright-langserver')
  augroup VimConfigPyright
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyright',
          \ 'cmd': {server_info -> ['pyright-langserver', '--stdio']},
          \ 'root_uri': {server_info -> lsp#utils#path_to_uri(
          \   lsp#utils#find_nearest_parent_file_directory(
          \     lsp#utils#get_buffer_path(),
          \     ['pyproject.toml', 'setup.cfg', 'setup.py', '.git/']))},
          \ 'allowlist': ['python'],
          \ })
  augroup END
endif

if executable('bash-language-server')
  augroup VimConfigBashLsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'bash-language-server',
          \ 'cmd': {server_info -> ['bash-language-server', 'start']},
          \ 'allowlist': ['sh', 'bash'],
          \ })
  augroup END
endif

function! s:ConfigureLspBuffer() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc')
    setlocal tagfunc=lsp#tagfunc
  endif

  nmap <silent><buffer> gd <plug>(lsp-definition)
  nmap <silent><buffer> grr <plug>(lsp-references)
  nmap <silent><buffer> gri <plug>(lsp-implementation)
  nmap <silent><buffer> K <plug>(lsp-hover)
  nmap <silent><buffer> <leader>rn <plug>(lsp-rename)
  nmap <silent><buffer> <leader>ca <plug>(lsp-code-action)
  nmap <silent><buffer> [d <plug>(lsp-previous-diagnostic)
  nmap <silent><buffer> ]d <plug>(lsp-next-diagnostic)
endfunction

augroup VimConfigLspMappings
  autocmd!
  autocmd User lsp_buffer_enabled call s:ConfigureLspBuffer()
augroup END

