local opt = vim.opt

opt.splitbelow = true
opt.splitright = true

-- Neovim already stores swap and backup files under stdpath("state").
opt.undofile = true

opt.diffopt:append({ "algorithm:patience" })
opt.completeopt = { "menuone", "noselect", "popup" }
opt.spelllang = { "en_us" }
opt.spelloptions:append({ "camel" })
opt.termguicolors = true
opt.background = "dark"

-- Turn off vim mouse because otherwise copy/paste doesn't work
opt.mouse = ""
