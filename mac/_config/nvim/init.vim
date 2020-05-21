let g:python3_host_prog = '/Users/dvbalen/.pyenv/versions/py3vim/bin/python3'

" Plugins!
let need_to_install_plugins = 0
if empty(glob('~/.config/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    let need_to_install_plugins = 1
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'morhetz/gruvbox'
Plug 'majutsushi/tagbar'
call plug#end()

filetype plugin indent on
syntax on

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif

" Make splits open below or right (more intuitive)
set splitbelow
set splitright

" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory^=~/.comfig/nvim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has("patch-8.1.0251")
	" consolidate the writebackups -- not a big
	" deal either way, since they usually get deleted
	set backupdir^=~/.comfig/nvim/backup//
end

" persist the undo tree for each file
set undofile
set undodir^=~/.comfig/nvim/undo//

" The “patience” algorithm often produces more human-readable output than the default, “myers.”
" https://bramcohen.livejournal.com/73318.html
if has("patch-8.1.0360")
	set diffopt+=internal,algorithm:patience
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
colorscheme gruvbox
set background=dark

" tag list
" using universal-ctags https://github.com/universal-ctags/ctags
" https://andrew.stwrt.ca/posts/vim-ctags/

map <leader>t :TagbarToggle<CR>

let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }

let g:tagbar_type_yaml = {
    \ 'ctagstype' : 'yaml',
    \ 'kinds' : [
        \ 'a:anchors',
        \ 's:section',
        \ 'e:entry'
    \ ],
  \ 'sro' : '.',
    \ 'scope2kind': {
      \ 'section': 's',
      \ 'entry': 'e'
    \ },
    \ 'kind2scope': {
      \ 's': 'section',
      \ 'e': 'entry'
    \ },
    \ 'sort' : 0
    \ }

let g:tagbar_type_ansible = {
	\ 'ctagstype' : 'ansible',
	\ 'kinds' : [
		\ 't:tasks'
	\ ],
	\ 'sort' : 0
\ }

let g:tagbar_type_json = {
    \ 'ctagstype' : 'json',
    \ 'kinds' : [
      \ 'o:objects',
      \ 'a:arrays',
      \ 'n:numbers',
      \ 's:strings',
      \ 'b:booleans',
      \ 'z:nulls'
    \ ],
  \ 'sro' : '.',
    \ 'scope2kind': {
    \ 'object': 'o',
      \ 'array': 'a',
      \ 'number': 'n',
      \ 'string': 's',
      \ 'boolean': 'b',
      \ 'null': 'z'
    \ },
    \ 'kind2scope': {
    \ 'o': 'object',
      \ 'a': 'array',
      \ 'n': 'number',
      \ 's': 'string',
      \ 'b': 'boolean',
      \ 'z': 'null'
    \ },
    \ 'sort' : 0
    \ }

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }
