local make_config = function()
  local settings = {
    json = {
      validate = { enable = true },
    },
  }

  local has_schemastore, schemastore = pcall(require, "schemastore")
  if has_schemastore then
    settings.json.schemas = schemastore.json.schemas()
  end

  return { settings = settings }
end

require("me.lsp").extend_lsp_config("jsonls", make_config())
