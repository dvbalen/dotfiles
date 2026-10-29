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
    local started = pcall(vim.treesitter.start, event.buf)
    if started and vim.bo[event.buf].filetype == "python" then
      -- Tree-sitter clears 'syntax', but python#GetIndent() uses synstack()
      -- to ignore brackets in strings and comments. Keep that information
      -- available alongside Tree-sitter highlighting.
      vim.bo[event.buf].syntax = "python"
    end
  end,
})
