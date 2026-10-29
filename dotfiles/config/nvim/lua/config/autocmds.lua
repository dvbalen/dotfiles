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

-- Some terminals retain the shell's cursor shape after Ctrl-Z/fg. Changing
-- guicursor on both sides of the suspend forces the TUI to send it again.
local cursor_group = vim.api.nvim_create_augroup("SuspendCursorRestore", { clear = true })
local suspended_cursor

vim.api.nvim_create_autocmd("VimSuspend", {
  group = cursor_group,
  callback = function()
    suspended_cursor = vim.o.guicursor
    if suspended_cursor ~= "" then
      vim.o.guicursor = "a:block-blinkon0"
    end
  end,
  desc = "Save the editor cursor style and reset the shell cursor",
})

-- Some terminals retain the shell's cursor shape after Ctrl-Z/fg. Changing
-- guicursor on both sides of the suspend forces the TUI to send it again.
local cursor_group = vim.api.nvim_create_augroup("SuspendCursorRestore", { clear = true })
local suspended_cursor

vim.api.nvim_create_autocmd("VimSuspend", {
  group = cursor_group,
  callback = function()
    suspended_cursor = vim.o.guicursor
    if suspended_cursor ~= "" then
      vim.o.guicursor = "a:block-blinkon0"
    end
  end,
  desc = "Save the editor cursor style and reset the shell cursor",
})

vim.api.nvim_create_autocmd("VimResume", {
  group = cursor_group,
  callback = function()
    vim.schedule(function()
      if suspended_cursor ~= nil then
        vim.o.guicursor = suspended_cursor
        suspended_cursor = nil
      end
      vim.cmd("redraw!")
    end)
  end,
  desc = "Restore the editor cursor style after returning with fg",
})
