vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ProseSpellChecking", { clear = true }),
  pattern = {
    "asciidoc",
    "gitcommit",
    "markdown",
    "rst",
    "text",
    "tex",
    "typst",
  },
  callback = function()
    vim.opt_local.spell = true
  end,
  desc = "Enable spell checking in prose and markup",
})
