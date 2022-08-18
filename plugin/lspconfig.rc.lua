local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local on_attach = require("me.lsp").on_attach
local capabilities = require("me.lsp").make_capabilities()

local clients = {
  "bashls",
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
  "yamlls",
}

local lsp_opt = {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = { debounce_text_change = 150 },
}

for _, name in ipairs(clients) do
  local m_ok, m = pcall(require, "me.lsp.conf." .. name)
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
