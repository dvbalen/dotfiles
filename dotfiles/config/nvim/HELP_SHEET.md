# Neovim command summary

<!-- cspell:ignore nvim checkhealth langserver checktime bashls shellcheck shfmt foldmethod setlocal foldcolumn foldlevel mkview loadview viewoptions foldexpr docstrings pytest copen cclose cnewer makeprg debugpy NVIM -->

This configuration lives in `config/` and targets Neovim 0.12 or newer. It
uses Neovim's native package manager, native LSP completion, BasedPyright for
Python, bash-language-server for shell scripts, Aerial for symbols, Gitsigns
for lightweight Git integration, and Vinegar for directory browsing.

## Start and maintain the configuration

Use `config/` directly by symlinking it to Neovim's standard configuration
location:

```sh
ln -s /path/to/workdir/config ~/.config/nvim
```

If `~/.config/nvim` already exists, move or merge it before creating the
symlink. On the first start, approve the plugin installation prompt. Useful
maintenance commands are:

```vim
:lua vim.pack.update()
:checkhealth vim.lsp
:checkhealth nvim-treesitter
```

The first command updates plugins. Updating `nvim-treesitter` also triggers a
parser update.

## Python and BasedPyright

The configuration starts `basedpyright-langserver` when it is on `PATH`, with
`pyright-langserver` as a fallback. A convenient user-level installation is:

```sh
uv tool install basedpyright
```

Make sure the uv tool bin directory is on `PATH`, then restart Neovim. Open a
Python file and use `:checkhealth vim.lsp` if the server does not attach.

LSP completion opens automatically while typing. In Insert mode:

- `<C-n>` and `<C-p>` select the next or previous completion.
- `<C-y>` accepts the selected completion.
- `<C-e>` closes the completion menu.

Python navigation and editing mappings are buffer-local and become active
when BasedPyright attaches:

| Mapping | Action |
| --- | --- |
| `gd` | Go to definition |
| `grr` | List references |
| `gri` | Go to implementation |
| `K` | Show hover documentation |
| `<Space>rn` | Rename a symbol |
| `<Space>ca` | Show code actions |
| `[d` / `]d` | Previous or next diagnostic |
| `gO` | List document symbols using Neovim's built-in mapping |
| `<Space>t` | Toggle the Aerial symbol outline |
| `<Space>sp` / `<Space>sn` | Previous or next Aerial symbol |

Diagnostics are underlined, sorted by severity, and displayed as virtual text
on the current line. The configuration does not automatically format files or
select a project's test command. If an external command changes an open file,
run `:checktime` to reload it.

## Bash language support

When `bash-language-server` is on `PATH`, the configuration enables `bashls`
for shell-script buffers. It receives the same buffer-local LSP mappings and
completion behavior listed in the Python section where the server supports
the corresponding operation. If `shellcheck` and `shfmt` are also on `PATH`,
`bash-language-server` discovers them automatically for diagnostics and LSP
formatting; this configuration does not install or configure those tools.

## Folding

Folding hides ranges of lines without changing or deleting their contents.
Fold state belongs to a window, so two windows showing the same buffer can
have different folds open. This configuration does not select a folding
method; Neovim therefore starts with its default `foldmethod=manual`.

The most useful built-in commands work with manual, indent, Tree-sitter, and
other fold methods:

| Command       | Action                                                   |
|---------------|----------------------------------------------------------|
| `za` / `zA`   | Toggle one fold / toggle it and nested folds recursively |
| `zo` / `zO`   | Open one fold / open nested folds recursively            |
| `zc` / `zC`   | Close one fold / close nested folds recursively          |
| `zR` / `zM`   | Open all folds / close all folds                         |
| `zr` / `zm`   | Open one more fold level / close one more fold level     |
| `zj` / `zk`   | Move to the next / previous fold                         |
| `zv`          | Open enough folds to reveal the cursor line              |
| `zx`          | Recompute folds and reveal the cursor line               |
| `zi`          | Toggle folding without deleting fold definitions         |

For manual folds, select lines in Visual-line mode with `V`, extend the
selection, and press `zf`. A motion also works, such as `zf}` to fold through
the next paragraph. Manual-fold maintenance commands are:

| Command | Action                                                        |
|---------|---------------------------------------------------------------|
| `zf`    | Create a fold from a motion or Visual selection               |
| `zF`    | Create a fold covering the current line or a supplied count   |
| `zd`    | Delete the fold definition under the cursor                   |
| `zD`    | Delete that fold definition and its nested fold definitions   |
| `zE`    | Delete all manual fold definitions in the current window      |

Deleting a fold definition does not delete buffer text. The deletion commands
apply only to manual or marker folds.

Select a different method for the current window with `:setlocal`:

```vim
:setlocal foldmethod=manual  " Explicit, manually created folds
:setlocal foldmethod=indent  " Folds derived from indentation
:setlocal foldmethod=marker  " Folds derived from {{{ and }}} markers
:setlocal foldmethod=diff    " Unchanged regions in a diff window
```

Useful display controls are:

```vim
:setlocal foldcolumn=1  " Display a one-column fold guide
:setlocal foldlevel=0   " Close all fold levels
:setlocal foldlevel=1   " Leave only the outermost level open
:setlocal foldlevel=99  " Start with folds available but open
```

Manual folds and open/closed fold state are normally lost when the file is
abandoned. Save and restore the current view with:

```vim
:mkview
:loadview
```

Neovim's default `viewoptions` includes folds. This configuration does not
automatically run either command, which avoids restoring stale views without
an explicit request.

### Python folding

For a quick indentation-based view of a Python buffer:

```vim
:setlocal foldmethod=indent
:setlocal foldlevel=99
```

This treats each deeper indentation level as a nested fold. It requires no
parser, but it is not syntax-aware and can create more folds than desired.

For syntax-aware Python folding, use the Tree-sitter parser installed by this
configuration:

```vim
:setlocal foldmethod=expr
:setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
:setlocal foldlevel=99
```

The current Python Tree-sitter fold query recognizes classes, functions,
control-flow statements, `with`, `try`, and `match` statements, imports,
parameters and argument lists, comprehensions, collections, parenthesized
expressions, and strings. This can include docstrings and multiline strings.
Use `zM` to collapse the resulting structure, `zR` to reopen everything, and
`zx` if folds appear stale after substantial edits.

To return the current Python window to explicitly created folds:

```vim
:setlocal foldmethod=manual
```

Tree-sitter folding requires the Python parser to be installed and active.
Check it with `:checkhealth nvim-treesitter` if the expression method produces
no folds or reports a parser error.

## Spelling

Spell checking is enabled automatically for text, Markdown, AsciiDoc,
reStructuredText, TeX, Typst, and Git commit messages. The dictionary uses US
English and splits CamelCase words into separately checked components.

| Mapping | Action |
| --- | --- |
| `[s` / `]s` | Previous or next spelling issue |
| `z=` | Show corrections for the word under the cursor |
| `1z=` | Apply the first suggested correction |
| `zg` | Add the word to the persistent user dictionary |
| `zG` | Accept the word for the current session |
| `zw` | Mark the word as incorrect |
| `zug` | Undo `zg` for the word |

Use `:setlocal spell!` to toggle checking in the current window. CSpell is not
run or configured by this Neovim setup; any project-level CSpell integration
remains separate.

## Running and navigating Python tests

Neovim includes a pytest compiler that parses tracebacks into its quickfix
list. From a Python test buffer, initialize it and run a test with:

```vim
:compiler pytest
:make! %::test_function_name
:copen
```

Use `:update` before `:make!` to save the current buffer when necessary.
Common test targets are:

```vim
:make!                          " Run all tests
:make! %                        " Run the current test file
:make! %::test_function_name    " Run one test function
:make! %::TestClass::test_name  " Run one test method
```

Pytest traceback frames become quickfix entries, making it possible to move
between the failed test and the application code that triggered it:

| Mapping or command | Action |
| --- | --- |
| `]q` | Jump to the next error or traceback location |
| `[q` | Jump to the previous error or traceback location |
| `Enter` | Open the selected entry in the quickfix window |
| `:copen` / `:cclose` | Open or close the quickfix window |
| `:colder` / `:cnewer` | Move between results from earlier or later runs |

The built-in compiler invokes `pytest` directly. For a uv-managed Python
environment, override the command after running `:compiler pytest`:

```vim
:setlocal makeprg=uv\ run\ pytest\ --tb=short\ --quiet
```

The same `:make!` commands and quickfix navigation then apply.

## Debugging Python

No DAP plugin is installed. The lightweight workflow is Python's built-in
debugger. Add a breakpoint in code:

```python
breakpoint()
```

Then run the relevant program or test in a Neovim terminal, for example:

```vim
:terminal python path/to/script.py
:terminal python -m pytest
```

Use the project's environment launcher when applicable, such as `uv run
python` instead of `python`. For an immediate debugger session:

```sh
python -m pdb path/to/script.py
```

Common pdb commands are `n` (next), `s` (step), `c` (continue), `p EXPR`
(print), `pp EXPR` (pretty-print), `l` (list source), and `q` (quit). If
interactive debugging becomes frequent, `nvim-dap`, `nvim-dap-python`, and
`debugpy` can be added later without requiring a full debugger UI.

## Git

Gitsigns displays added, changed, and deleted lines in the sign column. Its
mappings are available only in buffers belonging to a Git worktree:

| Mapping | Action |
| --- | --- |
| `[h` / `]h` | Previous or next changed hunk |
| `<Space>hp` | Preview the current hunk |
| `<Space>hs` | Stage the current hunk or visual selection |
| `<Space>hr` | Reset the current hunk or visual selection |
| `<Space>hu` | Undo the most recently staged hunk |
| `<Space>hb` | Show full blame information for the current line |
| `<Space>hd` | Diff the file against the index |

 Typical gutter indicators are:

|   Color/sign                  |  Meaning
|   ---                         |  ---
|   Green bar                   |  Added lines
|   Blue or changed-colored bar |  Modified lines
|   Red marker                  |  Deleted lines
|   Green/changed combination   |  Changed-and-added lines

  Confirm with:

  :Gitsigns preview_hunk

  or:

  git diff
  git diff --cached

  If the file is not inside a Git repository, the bar could instead be another sign such as an LSP diagnostic, but with this
  configuration a green gutter bar is most likely Gitsigns.

 Gitsigns version supports whole-branch review as well as changing the comparison used by the gutter
  signs. No additional plugin is needed.

  For reviewing changes introduced by dev-branch since it diverged from develop:

  :Gitsigns diff develop...dev-branch

  This opens a changed-file tree with diff windows. Press <Enter> to open a file and g? in the panel for its available
  mappings.

  For comparing the exact current contents of the two branch tips:

  :Gitsigns diff develop..dev-branch

  The distinction matters:

|  Comparison               | What it shows
|  ---                      | ---
|  develop...dev-branch     |  Changes on dev-branch since the common ancestor; usually appropriate for reviewing a proposed merge
|  develop..dev-branch      |  Differences between both branch tips, including differences caused by later changes on develop


  These commands compare committed revisions, so unrelated uncommitted edits are excluded. Gitsigns diff documentation
  (https://github.com/lewis6991/gitsigns.nvim/blob/main/doc/gitsigns.txt)

  To review through the existing gutter and hunk mappings, with dev-branch checked out:

  :Gitsigns change_base develop

  The current buffer’s signs now compare against develop. The configured mappings continue to work:

|   Mapping     | Action
|   ---         | ---
|   [h / ]h     | Previous / next hunk
|   <Space>hp   | Preview hunk
|   <Space>hd   | Open a diff against the selected base

  To apply that comparison to all buffers, including newly opened files:

  :lua require('gitsigns').change_base('develop', true)

  Restore the normal index comparison afterward:

  :lua require('gitsigns').reset_base(true)

  Unlike the committed branch comparison, changing the gutter base compares against the current buffer, so local edits
  are included. Also, <Space>hr remains a reset operation that changes buffer contents; it is not a review command.

   Gitsigns base and hunk documentation (https://github.com/lewis6991/gitsigns.nvim/blob/main/doc/gitsigns.txt)

  For branch review, start with :Gitsigns diff develop...dev-branch; use change_base when reviewing changes while
  navigating ordinary editing buffers.

   Gitsigns can review a single commit or compare commits within a branch.

  List commits on the current branch that are absent from develop:

  :terminal git log --oneline develop..HEAD

  Then review a specific commit:

  :Gitsigns show_commit abc1234

  This opens the changed-file tree and diffs for that commit against its first parent. For the latest commit:

  :Gitsigns show_commit HEAD

  Other useful comparisons:

|   Command                            | Review
|   ---                                | ---
|   :Gitsigns show_commit HEAD~1       | The commit immediately before the latest
|   :Gitsigns diff HEAD~3..HEAD        | Combined changes from the latest three commits
|   :Gitsigns diff abc1234..def5678    | Net changes between two commits
|   :Gitsigns diff abc1234^..abc1234   | One commit against its first parent, except a root commit

  Press <Enter> on a file to inspect its diff, and g? in the panel to see navigation commands. For merge commits,
  show_commit shows the comparison against the first parent rather than a combined merge diff. Gitsigns documentation
  (https://github.com/lewis6991/gitsigns.nvim/blob/main/doc/gitsigns.txt)

  For the current file alone:

  :Gitsigns diffthis abc1234

  That compares the current buffer against its version at that commit. To inspect only the changes introduced by a
historical commit, use show_commit; changing the gutter base would also include all subsequent changes and local
  edits.


Gitsigns intentionally handles only buffer-level Git operations. Continue to
use the Git CLI for repository-level work:

```vim
:terminal git status
:terminal git diff --staged
:terminal git commit
```


Vinegar keeps file navigation lightweight: press `-` in a normal file buffer
to open its parent directory.

## Themes

Gruvbox is the default. Switch themes with:

```vim
:Theme gruvbox
:Theme everforest
:Theme zenbones
:Theme kanagawa-dragon
```

For a whole session, start Neovim with an environment variable, for example:

```sh
NVIM_THEME=kanagawa-dragon nvim
```
