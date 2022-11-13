-- :fennel:1668300939
local has_phpactor_3f, phpactor = pcall(require, "phpactor")
if has_phpactor_3f then
  local mylsp = require("me.lsp")
  local phpactor_path = (vim.fn.stdpath("data") .. "/mason/packages/phpactor")
  local settings = {install = {path = phpactor_path, bin = (phpactor_path .. "/bin/phpactor")}, lspconfig = {options = {on_attach = mylsp.on_attach, capabilities = mylsp.make_capabilities()}}}
  return phpactor.setup(settings)
else
  return nil
end