" Let asyncomplete manage the popup while retaining the configured completeopt.
let g:asyncomplete_auto_completeopt = 0

augroup VimConfigCompletion
  autocmd!
  autocmd CompleteDone * if pumvisible() == 0 | silent! pclose | endif
augroup END
