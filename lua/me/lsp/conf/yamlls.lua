local make_config = function()
  local settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
    },
  }

  local has_schemastore, schemastore = pcall(require, "schemastore")
  if has_schemastore then
    settings.yaml.schemas = schemastore.json.schemas()
  end

  return { settings = settings }
end

require("me.lsp").extend_config("yamlls", make_config())
