vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.autocmds")
require("config.plugins")

require("plugins.gruvbox")
require("plugins.everforest")
require("plugins.zenbones")
require("plugins.kanagawa")
require("plugins.treesitter")
require("plugins.aerial")
require("plugins.gitsigns")
require("plugins.statusline")
require("plugins.lspconfig")

require("config.theme").setup()
require("config.keymaps")
