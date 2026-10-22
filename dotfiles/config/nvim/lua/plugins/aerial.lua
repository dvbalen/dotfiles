require("aerial").setup({
  backends = { "treesitter", "lsp", "markdown", "man" },
  layout = {
    default_direction = "prefer_right",
    max_width = { 40, 0.25 },
    min_width = 20,
  },
  show_guides = true,
  filter_kind = false,
})
