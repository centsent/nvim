-- :fennel:1668300349
local has_typescript_3f, typescript = pcall(require, "typescript")
if has_typescript_3f then
  local mylsp = require("me.lsp")
  return typescript.setup({server = {on_attach = mylsp.on_attach, capabilities = mylsp.make_capabilities()}})
else
  return nil
end