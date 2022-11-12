-- :fennel:1668262727
local has_lspconfig_3f, lspconfig = pcall(require, "lspconfig")
if has_lspconfig_3f then
  local mylsp = require("me.lsp")
  local servers = mylsp.get_servers()
  local function setup(name)
    local ok_3f, _ = pcall(require, ("me.lsp.conf." .. name))
    if not ok_3f then
      return lspconfig[name].setup({on_attach = mylsp.on_attach, capabilities = mylsp.capabilities})
    else
      return nil
    end
  end
  for _, name in ipairs(servers) do
    setup(name)
  end
  return nil
else
  return nil
end