vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  virtual_text = { current_line = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspMappingsAndCompletion", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    local function map(lhs, rhs, description)
      vim.keymap.set("n", lhs, rhs, {
        buffer = event.buf,
        desc = "LSP: " .. description,
        silent = true,
      })
    end

    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("grr", vim.lsp.buf.references, "List references")
    map("gri", vim.lsp.buf.implementation, "Go to implementation")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Previous diagnostic")
    map("]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Next diagnostic")

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end,
})

-- nvim-lspconfig supplies these server definitions; language servers remain
-- external programs. Prefer basedpyright when both are installed.
if vim.fn.executable("basedpyright-langserver") == 1 then
  vim.lsp.enable("basedpyright")
elseif vim.fn.executable("pyright-langserver") == 1 then
  vim.lsp.enable("pyright")
end

-- bashls inherits the same buffer-local LSP mappings above. It also uses
-- shellcheck and shfmt automatically when those executables are on PATH.
if vim.fn.executable("bash-language-server") == 1 then
  vim.lsp.enable("bashls")
end
