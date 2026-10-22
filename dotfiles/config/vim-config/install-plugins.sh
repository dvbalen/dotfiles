#!/usr/bin/env sh
set -eu

config_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
package_dir="$config_dir/pack/third-party/start"
mkdir -p "$package_dir"

install_or_update() {
  name=$1
  url=$2
  destination="$package_dir/$name"

  if [ -d "$destination/.git" ]; then
    printf 'Updating %s\n' "$name"
    git -C "$destination" pull --ff-only
  elif [ -e "$destination" ]; then
    printf 'Cannot install %s: %s already exists and is not a Git checkout\n' "$name" "$destination" >&2
    return 1
  else
    printf 'Installing %s\n' "$name"
    git clone --filter=blob:none "$url" "$destination"
  fi
}

install_or_update zenbones.nvim https://github.com/zenbones-theme/zenbones.nvim.git
install_or_update vim-lsp https://github.com/prabirshrestha/vim-lsp.git
install_or_update asyncomplete.vim https://github.com/prabirshrestha/asyncomplete.vim.git
install_or_update asyncomplete-lsp.vim https://github.com/prabirshrestha/asyncomplete-lsp.vim.git
install_or_update vim-gitgutter https://github.com/airblade/vim-gitgutter.git
install_or_update vim-fugitive https://github.com/tpope/vim-fugitive.git
install_or_update vista.vim https://github.com/liuchengxu/vista.vim.git
install_or_update vim-vinegar https://github.com/tpope/vim-vinegar.git

vim -Nu NONE -n -es \
  "+set packpath^=$config_dir" \
  '+silent! helptags ALL' \
  '+qall'
