local M = {}

local themes = {
  "gruvbox",
  "everforest",
  "zenbones",
  "kanagawa-dragon",
}

local function apply(name)
  local ok, error_message = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify(("Could not load colorscheme %q: %s"):format(name, error_message), vim.log.levels.ERROR)
    return false
  end
  return true
end

function M.setup()
  vim.api.nvim_create_user_command("Theme", function(command)
    apply(command.args)
  end, {
    nargs = 1,
    complete = function(arg_lead)
      return vim.tbl_filter(function(name)
        return name:find(arg_lead, 1, true) == 1
      end, themes)
    end,
    desc = "Switch colorscheme",
  })

  local selected = vim.env.NVIM_THEME or "zenbones"
  if not vim.tbl_contains(themes, selected) then
    vim.notify(("Unknown NVIM_THEME %q; using zenbones"):format(selected), vim.log.levels.WARN)
    selected = "zenbones"
  end

  if not apply(selected) and selected ~= "zenbones" then
    apply("zenbones")
  end
end

return M
