local has_lspconfig, lspconfig = pcall(require, "lspconfig")
if not has_lspconfig then
  return
end

local lsp = require("me.lsp")
local capabilities = lsp.make_capabilities()
local servers = lsp.get_servers()

local default_config = {
  capabilities = capabilities,
  on_attach = lsp.on_attach,
  flags = { debounce_text_change = 150 },
}

for _, name in ipairs(servers) do
  local has_m, m = pcall(require, "me.lsp.conf." .. name)
  if has_m and m ~= nil and m.make_config then
    local server_config = m.make_config()
    lspconfig[name].setup(vim.tbl_deep_extend("force", default_config, server_config))
  else
    lspconfig[name].setup(default_config)
  end
end

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
