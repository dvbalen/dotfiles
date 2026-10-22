" Let asyncomplete manage the popup while retaining the configured completeopt.
let g:asyncomplete_auto_completeopt = 0

augroup VimConfigCompletion
  autocmd!
  autocmd CompleteDone * if pumvisible() == 0 | silent! pclose | endif
augroup END

[vanbalende@iebdev22 plugins]$ cat git.vim
let g:gitgutter_map_keys = 0
let g:gitgutter_show_msg_on_hunk_jumping = 1

nmap <silent> ]h <Plug>(GitGutterNextHunk)
nmap <silent> [h <Plug>(GitGutterPrevHunk)
nmap <silent> <leader>hp <Plug>(GitGutterPreviewHunk)
nmap <silent> <leader>hs <Plug>(GitGutterStageHunk)
nmap <silent> <leader>hr <Plug>(GitGutterUndoHunk)
xmap <silent> <leader>hs <Plug>(GitGutterStageHunk)
xmap <silent> <leader>hr <Plug>(GitGutterUndoHunk)

nnoremap <silent> <leader>hb :Git blame<CR>
nnoremap <silent> <leader>hd :Gdiffsplit<CR>
