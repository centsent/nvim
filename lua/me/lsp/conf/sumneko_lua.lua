-- :fennel:1668275886
local has_lspconfig_3f, lspconfig = pcall(require, "lspconfig")
if has_lspconfig_3f then
  do
    local has_neodev_3f, neodev = pcall(require, "neodev")
    if has_neodev_3f then
      neodev.setup()
    else
    end
  end
  local mylsp = require("me.lsp")
  return lspconfig.sumneko_lua.setup({on_attach = mylsp.on_attach, capabilities = mylsp.make_capabilities(), settings = {Lua = {completion = {callSnippet = "Replace"}}}})
else
  return nil
end