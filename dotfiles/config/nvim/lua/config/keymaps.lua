local map = vim.keymap.set

map("n", "<leader>t", "<cmd>AerialToggle!<CR>", {
  desc = "Toggle symbols outline",
  silent = true,
})

map("n", "<leader>sp", "<cmd>AerialPrev<CR>", {
  desc = "Previous symbol",
  silent = true,
})

map("n", "<leader>sn", "<cmd>AerialNext<CR>", {
  desc = "Next symbol",
  silent = true,
})
