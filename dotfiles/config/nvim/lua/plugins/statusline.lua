local statusline = require("mini.statusline")

local function active_content()
  -- Keep the mode compact and reserve the flexible part of the statusline for
  -- the relative file name. The name also includes modified/read-only flags.
  local mode, mode_highlight = statusline.section_mode({ trunc_width = math.huge })
  local git = statusline.section_git({ trunc_width = 120 })
  local diagnostics = statusline.section_diagnostics({
    trunc_width = 100,
    icon = "",
  })

  return statusline.combine_groups({
    { hl = mode_highlight, strings = { mode } },
    "%<",
    { hl = "MiniStatuslineFilename", strings = { "%f%m%r" } },
    "%=",
    { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
    { hl = mode_highlight, strings = { "%l:%c" } },
  })
end

statusline.setup({
  use_icons = false,
  content = {
    active = active_content,
  },
})

vim.opt.laststatus = 3
