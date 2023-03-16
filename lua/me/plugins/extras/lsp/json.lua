-- :fennel:1678891807
local function on_new_config(new_config)
  local json_schemas = new_config.settings.json.schemas
  local schema_store = require("schemastore")
  new_config.settings.json.schemas = (json_schemas or {})
  return vim.list_extend(json_schemas, schema_store.json.schemas())
end
local jsonls_settings = {on_new_config = on_new_config, settings = {json = {format = {enable = true}, validate = {enable = true}}}}
return {dependencies = {"b0o/schemastore.nvim"}, opts = {servers = {jsonls = jsonls_settings}}, "neovim/nvim-lspconfig"}