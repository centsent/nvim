local safe_require = require("utils").safe_require

local make_config = function()
  local settings = {
    json = {},
  }

  local has_schemastore, schemastore = safe_require("schemastore")
  if has_schemastore then
    settings.json.schemas = schemastore.json.schemas()
  end

  return { settings = settings }
end

require("me.lsp").setup_with_config("jsonls", make_config())
