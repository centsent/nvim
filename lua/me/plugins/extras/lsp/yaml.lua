-- :fennel:1678891812
local function on_new_config(new_config)
  local json_schemas = new_config.settings.json.schemas
  local schema_store = require("schemastore")
  new_config.settings.yaml.schemas = (json_schemas or {})
  return vim.list_extend(json_schemas, schema_store.yaml.schemas())
end
local yamlls_settings = {on_new_config = on_new_config, settings = {yaml = {hover = true, completion = true, validate = true}}}
return {dependencies = {"b0o/schemastore.nvim"}, opts = {servers = {yamlls = yamlls_settings}}, "neovim/nvim-lspconfig"}