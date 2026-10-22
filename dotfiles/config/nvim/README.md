# Neovim configuration

This configuration targets Neovim 0.12 or newer and uses its native
`vim.pack` package manager. On first startup, Neovim asks for confirmation
before installing plugins and creates `nvim-pack-lock.json` in this directory.
Commit that lockfile if this directory is version controlled.

## Install

Symlink the directory as the Neovim configuration directory:

```sh
ln -s /path/to/this/config ~/.config/nvim
```

If `~/.config/nvim` already exists, move or merge it first.

## External requirements

- Neovim 0.12+
- Git
- `tree-sitter-cli` 0.26.1+, `curl`, `tar`, and a C compiler for parsers
- `basedpyright-langserver` (preferred) or `pyright-langserver` for Python LSP
- `bash-language-server` for Bash LSP
- `shellcheck` and `shfmt` for Bash diagnostics and formatting (optional)

Run `:checkhealth vim.lsp` to inspect LSP status. Update plugins with
`:lua vim.pack.update()`; the Tree-sitter parsers are updated after
`nvim-treesitter` changes.

## Layout

- `lua/config/`: editor options, package declarations, and keymaps
- `lua/plugins/`: one configuration module per configured plugin

`<Space>t` toggles Aerial, while `<Space>sp` and `<Space>sn` move to the
previous or next symbol. Neovim's built-in `gO` mapping also lists LSP
document symbols. Python and Bash LSP clients share the same buffer-local
navigation, hover, rename, code-action, completion, and diagnostic mappings.

Spell checking is enabled automatically for text, Markdown, common markup
filetypes, and Git commit messages. `[s` and `]s` retain their built-in
previous/next spelling-error behavior.

## Colorschemes

`zenbones` is the default. Switch at runtime with one of:

```vim
:Theme gruvbox
:Theme everforest
:Theme zenbones
:Theme kanagawa-dragon
```

The command supports tab completion. To select a theme for an entire session,
set `NVIM_THEME` before starting Neovim, for example:

```sh
NVIM_THEME=kanagawa-dragon nvim
```
