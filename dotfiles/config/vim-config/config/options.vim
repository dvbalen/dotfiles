set splitbelow
set splitright

set undofile
set diffopt+=algorithm:patience
set completeopt=menuone,noselect,popup
set spelllang=en_us
set spelloptions+=camel
set background=dark

if has('termguicolors')
  set termguicolors
endif

" Leave terminal mouse events to the terminal so selection and copy work.
set mouse=

filetype plugin indent on
syntax enable
