local M = {}

local o = function(option, value)
  vim.api.nvim_set_option(option, value)
end
local with = function(fn)
  return function()
    fn()
  end
end

local on_attach = function(client, bufnr)
  local buf_set_keymap = function(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local buf_set_option = function(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  local format_on_save = function()
    local formatters = require("formatter.config").values.filetype
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    if not formatters[ft] then
      vim.lsp.buf.formatting({})
    end
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Mappings.
  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<cr>", opts)
  buf_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<cr>", opts)
  buf_set_keymap("n", "gr", ":lua vim.lsp.buf.rename()<cr>", opts)
  buf_set_keymap("n", "gy", ":lua vim.lsp.buf.type_definition()<cr>", opts)
  buf_set_keymap("n", "gh", ":lua vim.lsp.buf.hover()<cr>", opts)
  buf_set_keymap("n", "gn", ":lua vim.diagnostic.goto_next()<cr>", opts)
  buf_set_keymap("n", "gp", ":lua vim.diagnostic.goto_prev()<cr>", opts)
  buf_set_keymap("n", "ga", ":lua vim.lsp.buf.code_action()<cr>", opts)

  -- Set updatetime for CursorHold
  -- 300ms of no cursor movement to trigger CursorHold
  o("updatetime", 300)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end,
  })

  -- have a fixed column for the diagnostics to appear in
  -- this removes the jitter when warnings/errors flow in
  o("signcolumn", "yes")

  -- Format on save
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = bufnr,
      callback = with(format_on_save),
    })
  end
end

M.on_attach = on_attach

local make_capabilities = function()
  local protocol = require("vim.lsp.protocol")
  -- Set up completion using nvim_cmp with LSP source
  local capabilities = require("cmp_nvim_lsp").update_capabilities(protocol.make_client_capabilities())

  return capabilities
end

M.make_capabilities = make_capabilities

return M
