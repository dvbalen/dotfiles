local pack_group = vim.api.nvim_create_augroup("NativePackageHooks", { clear = true })

-- Parser versions need to be kept in sync with nvim-treesitter updates.
vim.api.nvim_create_autocmd("PackChanged", {
  group = pack_group,
  callback = function(event)
    local data = event.data
    if not data or data.spec.name ~= "nvim-treesitter" then
      return
    end
    if data.kind ~= "install" and data.kind ~= "update" then
      return
    end

    if not data.active then
      vim.cmd.packadd("nvim-treesitter")
    end
    vim.schedule(function()
      vim.cmd.TSUpdate()
    end)
  end,
})

vim.pack.add({
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  { src = "https://github.com/sainnhe/everforest" },
  { src = "https://github.com/rktjmp/lush.nvim" },
  { src = "https://github.com/zenbones-theme/zenbones.nvim" },
  { src = "https://github.com/rebelot/kanagawa.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/stevearc/aerial.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/nvim-mini/mini.statusline", version = "stable" },
  { src = "https://github.com/tpope/vim-vinegar" },
}, { load = true })
