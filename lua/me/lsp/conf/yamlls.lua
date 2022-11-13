-- :fennel:1668300156
local has_lspconfig_3f, lspconfig = pcall(require, "lspconfig")
if has_lspconfig_3f then
  local mylsp = require("me.lsp")
  local function make_config()
    local settings = {yaml = {hover = true, completion = true, validate = true}}
    do
      local has_schemastore_3f, schemastore = pcall(require, "schemastore")
      if has_schemastore_3f then
        settings.yaml.schemas = schemastore.json.schemas()
      else
      end
    end
    return {on_attach = mylsp.on_attach, capabilities = mylsp.make_capabilities(), settings = settings}
  end
  return lspconfig.yamlls.setup(make_config())
else
  return nil
end