function! VimConfigMode() abort
  let l:modes = {
        \ 'n': 'N', 'no': 'N·OP', 'v': 'V', 'V': 'V-L', "\<C-v>": 'V-B',
        \ 's': 'S', 'S': 'S-L', "\<C-s>": 'S-B', 'i': 'I', 'R': 'R',
        \ 'c': 'C', 't': 'T',
        \ }
  return get(l:modes, mode(), toupper(mode()))
endfunction

function! VimConfigGitBranch() abort
  if !exists('*FugitiveHead')
    return ''
  endif
  let l:branch = FugitiveHead()
  return empty(l:branch) ? '' : ' Git:' . l:branch
endfunction

" Keep the filename as the only left-side item allowed to consume space.
set laststatus=2
set statusline=%#StatusLine#\ %{VimConfigMode()}\ %<%f%m%r
set statusline+=%=
set statusline+=%{VimConfigGitBranch()}\ %l:%c\
