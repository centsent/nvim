local has_lspconfig, lspconfig = pcall(require, "lspconfig")
if not has_lspconfig then
  return
end

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local lsp = require("me.lsp")
local servers = lsp.get_servers()

local setup = function(name)
  local ok, _ = pcall(require, "me.lsp.conf." .. name)

  if not ok then
    local default_config = lsp.get_default_config()
    lspconfig[name].setup(default_config)
  end
end

for _, name in ipairs(servers) do
  setup(name)
end
