require("gruvbox").setup({
  terminal_colors = true,
  contrast = "",
  overrides = {
    DiffAdd = { fg = "#b8bb26", bg = "#3c3c25", bold = true },
    DiffChange = { fg = "#8ec07c", bg = "#383228", bold = true },
    DiffText = { fg = "#fabd2f", bg = "#483d28" },
    DiffDelete = { fg = "#fb4934", bg = "#372827", bold = true },

    -- Semantic highlights supplied by Python language servers.
    ["@lsp.type.parameter"] = { fg = "#98971a" },
    ["@lsp.type.property"] = { fg = "#8ec07c" },
    ["@lsp.type.decorator"] = { fg = "#fabd2f", bold = true },
  },
})
