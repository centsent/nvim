local safe_require = require("utils").safe_require
local has_lspconfig, lspconfig = safe_require("lspconfig")
if not has_lspconfig then
  return
end

local mylsp = require("me.lsp")

local make_config = function()
  local settings = {
    json = {
      validate = { enable = true },
    },
  }

  local has_schemastore, schemastore = safe_require("schemastore")
  if has_schemastore then
    settings.json.schemas = schemastore.json.schemas()
  end

  return {
    on_attach = mylsp.on_attach,
    capabilities = mylsp.make_capabilities(),
    settings = settings,
  }
end

lspconfig.jsonls.setup(make_config())
