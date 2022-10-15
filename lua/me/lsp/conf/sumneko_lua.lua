local safe_require = require("utils").safe_require
local has_lspconfig, lspconfig = safe_require("lspconfig")
if not has_lspconfig then
  return
end

local has_neodev, neodev = safe_require("neodev")
if has_neodev then
  neodev.setup()
end

lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})
