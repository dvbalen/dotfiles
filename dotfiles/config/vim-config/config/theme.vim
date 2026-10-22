" Lush is Neovim-only.  Zenbones ships generated Vim colors and enables its
" compatibility path automatically in Vim; setting this explicitly documents
" the intended mode.
let g:zenbones_compat = 1
let g:zenbones_darken_comments = 45

let s:themes = [
      \ 'zenbones',
      \ 'zenwritten',
      \ 'neobones',
      \ 'vimbones',
      \ 'rosebones',
      \ 'forestbones',
      \ 'nordbones',
      \ 'tokyobones',
      \ 'seoulbones',
      \ 'duckbones',
      \ 'zenburned',
      \ 'kanagawabones',
      \ ]

function! s:CompleteTheme(lead, command_line, cursor_position) abort
  return filter(copy(s:themes), 'stridx(v:val, a:lead) == 0')
endfunction

function! s:ApplyTheme(name) abort
  if index(s:themes, a:name) < 0
    echohl WarningMsg
    echomsg 'Unknown theme ' . string(a:name) . '; using zenbones'
    echohl None
    let l:name = 'zenbones'
  else
    let l:name = a:name
  endif

  try
    execute 'colorscheme ' . l:name
  catch /^Vim\%((\a\+)\)\=:E185/
    echohl WarningMsg
    echomsg 'Zenbones is not installed; run vim-config/install-plugins.sh'
    echohl None
    colorscheme default
    set background=dark
  endtry
endfunction

command! -nargs=1 -complete=customlist,<SID>CompleteTheme Theme call <SID>ApplyTheme(<q-args>)

let s:selected_theme = empty($VIM_THEME) ? 'zenbones' : $VIM_THEME
call s:ApplyTheme(s:selected_theme)
