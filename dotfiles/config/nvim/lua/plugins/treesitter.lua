local treesitter = require("nvim-treesitter")

treesitter.setup({})

local languages = {
  "bash",
  "css",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "vim",
  "vimdoc",
  "yaml",
}

local filetypes = {
  "bash",
  "css",
  "help",
  "json",
  "lua",
  "markdown",
  "python",
  "vim",
  "yaml",
}

-- This is asynchronous and is a no-op for parsers that are already installed.
treesitter.install(languages)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
  pattern = filetypes,
  callback = function(event)
    pcall(vim.treesitter.start, event.buf)
  end,
})
