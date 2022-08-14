local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local M = {}
local protocol = require("vim.lsp.protocol")
local o = function(option, value)
  vim.api.nvim_set_option(option, value)
end
local with = function(fn)
  return function()
    fn()
  end
end

local function on_attach(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
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
  buf_set_keymap("n", "gn", ":lua vim.lsp.diagnostic.goto_next()<cr>", opts)
  buf_set_keymap("n", "gp", ":lua vim.lsp.diagnostic.goto_prev()<cr>", opts)
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

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = bufnr,
      callback = with(vim.lsp.buf.formatting),
    })
  end
end

M.on_attach = on_attach

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").update_capabilities(protocol.make_client_capabilities())

local clients = {
  "clangd",
  "csharp_ls",
  "cssls",
  "cmake",
  "gopls",
  "html",
  "jsonls",
  "julials",
  "phpactor",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "tsserver",
  "vuels",
}

local lsp_opt = {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = { debounce_text_change = 150 },
}

for _, name in ipairs(clients) do
  local m_ok, m = pcall(require, "lsp." .. name .. "_config")
  if m_ok and m.make_config then
    local config = m.make_config()
    lspconfig[name].setup(vim.tbl_deep_extend("force", lsp_opt, config))
  else
    lspconfig[name].setup(lsp_opt)
  end
end

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

return M
