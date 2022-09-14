local safe_require = require("utils").safe_require

local make_config = function()
  local settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
    },
  }

  local has_schemastore, schemastore = safe_require("schemastore")
  if has_schemastore then
    settings.yaml.schemas = schemastore.json.schemas()
  end

  return { settings = settings }
end

require("me.lsp").setup_with_config("yamlls", make_config())
