-- :fennel:1668300666
local has_rt_3f, rt = pcall(require, "rust-tools")
if has_rt_3f then
  local mylsp = require("me.lsp")
  local function on_attach(client, bufnr)
    return mylsp.on_attach(client, bufnr)
  end
  return rt.setup({server = {on_attach = on_attach, capabilities = mylsp.make_capabilities()}})
else
  return nil
end