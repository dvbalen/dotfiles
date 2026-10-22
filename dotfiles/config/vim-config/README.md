# Vim configuration

This is a Vim 8.2+ counterpart to `../config`. It leaves the Neovim
configuration untouched and uses Vimscript plus Vim's native package layout.

## Install

Install or update the plugins:

```sh
./vim-config/install-plugins.sh
```

Use the configuration in place for a trial:

```sh
vim -Nu /home/vanbalende/src/codex/workdir/vim-config/vimrc file.py
```

To make it the normal Vim configuration, either source it from `~/.vimrc`:

```vim
source /home/vanbalende/src/codex/workdir/vim-config/vimrc
```

or link the directory and entry point after preserving anything already at
those locations:

```sh
ln -s /home/vanbalende/src/codex/workdir/vim-config ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
```

The first approach is safer when `~/.vim` or `~/.vimrc` already contains
configuration.

## External tools

The corresponding features activate when these executables are on `PATH`:

| Tool                         | Purpose                                      |
|------------------------------|----------------------------------------------|
| `basedpyright-langserver`    | Preferred Python language server             |
| `pyright-langserver`         | Python fallback when BasedPyright is absent  |
| `bash-language-server`       | Bash language server                         |
| `shellcheck`                 | Bash diagnostics used by the language server |
| `shfmt`                      | Bash formatting support for project commands |
| `git`                        | Fugitive and GitGutter                       |

Vim-lsp starts at the closest `pyproject.toml`, `setup.cfg`, `setup.py`, or
`.git` directory. BasedPyright therefore receives the project root and can
discover project configuration and a conventional local `.venv`.

## Theme

Zenbones is loaded in Vim compatibility mode without Lush:

```vim
let g:zenbones_compat = 1
colorscheme zenbones
```

Select another generated theme at startup:

```sh
VIM_THEME=zenwritten vim
```

or while Vim is running:

```vim
:Theme forestbones
```

## Important mappings

| Mapping       | Action                                      |
|---------------|---------------------------------------------|
| `<leader>t`   | Toggle the Vista symbol outline             |
| `<leader>sp`  | Previous method/function                    |
| `<leader>sn`  | Next method/function                        |
| `gd`          | Go to LSP definition                        |
| `grr`         | List LSP references                         |
| `gri`         | Go to LSP implementation                    |
| `K`           | Show LSP hover information                  |
| `<leader>rn`  | Rename through the language server          |
| `<leader>ca`  | Request an LSP code action                  |
| `[d`, `]d`    | Previous or next diagnostic                 |
| `[h`, `]h`    | Previous or next Git hunk                   |
| `<leader>hp`  | Preview Git hunk                            |
| `<leader>hs`  | Stage Git hunk or selected lines            |
| `<leader>hr`  | Undo working-tree changes in the Git hunk   |
| `<leader>hb`  | Open Fugitive blame                         |
| `<leader>hd`  | Diff the current file                       |

`vim-gitgutter` does not provide the exact Gitsigns operation used by the
Neovim `<leader>hu` mapping to unstage one hunk. Use Fugitive or command-line
Git to inspect the index and unstage the intended patch explicitly.

## Differences from the Neovim configuration

- Vim's syntax engine replaces Tree-sitter highlighting and folding.
- Vim-lsp and asyncomplete replace Neovim's built-in LSP and completion APIs.
- Vista replaces Aerial; its LSP outline is flatter than Aerial's Tree-sitter
  outline.
- GitGutter and Fugitive split the responsibilities handled by Gitsigns.
- The native statusline keeps the filename dominant and shows only mode, Git
  branch, modified/read-only flags, and cursor position.
- Zenbones compatibility mode uses its generated Vim colors. Lush-based live
  theme extension remains Neovim-only.

[vanbalende@iebdev22 vim-config]$ cat
config/             install-plugins.sh  README.md           vimrc
[vanbalende@iebdev22 vim-config]$ cat vimrc
" Vim counterpart to ../config.  Vim 8.2.4780 or newer is recommended.
scriptencoding utf-8

let mapleader = " "
let maplocalleader = " "

let s:config_root = fnamemodify(resolve(expand('<sfile>:p')), ':h')
execute 'set runtimepath^=' . fnameescape(s:config_root)
execute 'set packpath^=' . fnameescape(s:config_root)

function! s:Source(relative_path) abort
  execute 'source ' . fnameescape(s:config_root . '/' . a:relative_path)
endfunction

call s:Source('config/options.vim')
call s:Source('config/autocmds.vim')

" Define plugin settings and User autocommands before loading native packages.
call s:Source('config/plugins/lsp.vim')
call s:Source('config/plugins/git.vim')
call s:Source('config/plugins/vista.vim')
call s:Source('config/plugins/completion.vim')

" This is needed when this directory is used with `vim -Nu .../vimrc` rather
" than installed as ~/.vim.
packloadall

call s:Source('config/theme.vim')
call s:Source('config/statusline.vim')
call s:Source('config/keymaps.vim')

[vanbalende@iebdev22 vim-config]$ ls
config  install-plugins.sh  README.md  vimrc
[vanbalende@iebdev22 vim-config]$ cat README.md
# Vim configuration

This is a Vim 8.2+ counterpart to `../config`. It leaves the Neovim
configuration untouched and uses Vimscript plus Vim's native package layout.

## Install

Install or update the plugins:

```sh
./vim-config/install-plugins.sh
```

Use the configuration in place for a trial:

```sh
vim -Nu /home/vanbalende/src/codex/workdir/vim-config/vimrc file.py
```

To make it the normal Vim configuration, either source it from `~/.vimrc`:

```vim
source /home/vanbalende/src/codex/workdir/vim-config/vimrc
```

or link the directory and entry point after preserving anything already at
those locations:

```sh
ln -s /home/vanbalende/src/codex/workdir/vim-config ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
```

The first approach is safer when `~/.vim` or `~/.vimrc` already contains
configuration.

## External tools

The corresponding features activate when these executables are on `PATH`:

| Tool                         | Purpose                                      |
|------------------------------|----------------------------------------------|
| `basedpyright-langserver`    | Preferred Python language server             |
| `pyright-langserver`         | Python fallback when BasedPyright is absent  |
| `bash-language-server`       | Bash language server                         |
| `shellcheck`                 | Bash diagnostics used by the language server |
| `shfmt`                      | Bash formatting support for project commands |
| `git`                        | Fugitive and GitGutter                       |

Vim-lsp starts at the closest `pyproject.toml`, `setup.cfg`, `setup.py`, or
`.git` directory. BasedPyright therefore receives the project root and can
discover project configuration and a conventional local `.venv`.

## Theme

Zenbones is loaded in Vim compatibility mode without Lush:

```vim
let g:zenbones_compat = 1
colorscheme zenbones
```

Select another generated theme at startup:

```sh
VIM_THEME=zenwritten vim
```

or while Vim is running:

```vim
:Theme forestbones
```

## Important mappings

| Mapping       | Action                                      |
|---------------|---------------------------------------------|
| `<leader>t`   | Toggle the Vista symbol outline             |
| `<leader>sp`  | Previous method/function                    |
| `<leader>sn`  | Next method/function                        |
| `gd`          | Go to LSP definition                        |
| `grr`         | List LSP references                         |
| `gri`         | Go to LSP implementation                    |
| `K`           | Show LSP hover information                  |
| `<leader>rn`  | Rename through the language server          |
| `<leader>ca`  | Request an LSP code action                  |
| `[d`, `]d`    | Previous or next diagnostic                 |
| `[h`, `]h`    | Previous or next Git hunk                   |
| `<leader>hp`  | Preview Git hunk                            |
| `<leader>hs`  | Stage Git hunk or selected lines            |
| `<leader>hr`  | Undo working-tree changes in the Git hunk   |
| `<leader>hb`  | Open Fugitive blame                         |
| `<leader>hd`  | Diff the current file                       |

`vim-gitgutter` does not provide the exact Gitsigns operation used by the
Neovim `<leader>hu` mapping to unstage one hunk. Use Fugitive or command-line
Git to inspect the index and unstage the intended patch explicitly.

## Differences from the Neovim configuration

- Vim's syntax engine replaces Tree-sitter highlighting and folding.
- Vim-lsp and asyncomplete replace Neovim's built-in LSP and completion APIs.
- Vista replaces Aerial; its LSP outline is flatter than Aerial's Tree-sitter
  outline.
- GitGutter and Fugitive split the responsibilities handled by Gitsigns.
- The native statusline keeps the filename dominant and shows only mode, Git
  branch, modified/read-only flags, and cursor position.
- Zenbones compatibility mode uses its generated Vim colors. Lush-based live
  theme extension remains Neovim-only.

