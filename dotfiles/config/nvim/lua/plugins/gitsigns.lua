require("gitsigns").setup({
  current_line_blame = false,
  on_attach = function(buffer)
    local gitsigns = require("gitsigns")

    local function map(mode, lhs, rhs, description)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = buffer,
        desc = "Git: " .. description,
        silent = true,
      })
    end

    map("n", "]h", function()
      gitsigns.nav_hunk("next")
    end, "Next hunk")
    map("n", "[h", function()
      gitsigns.nav_hunk("prev")
    end, "Previous hunk")
    map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
    map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
    map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
    map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo staged hunk")
    map("n", "<leader>hb", function()
      gitsigns.blame_line({ full = true })
    end, "Blame line")
    map("n", "<leader>hd", gitsigns.diffthis, "Diff against index")
    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Stage selected lines")
    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Reset selected lines")
  end,
})
