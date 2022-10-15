local safe_require = require("utils").safe_require
local has_lspconfig, lspconfig = safe_require("lspconfig")
if not has_lspconfig then
  return
end

local has_neodev, neodev = safe_require("neodev")
if has_neodev then
  neodev.setup()
end

local mylsp = require("me.lsp")
lspconfig.sumneko_lua.setup({
  on_attach = mylsp.on_attach,
  capabilities = mylsp.make_capabilities(),
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})
