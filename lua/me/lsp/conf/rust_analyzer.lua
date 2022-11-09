local utils = require("utils")
local has_rt, rt = utils.safe_require("rust-tools")
if not has_rt then
  return
end

local mylsp = require("me.lsp")

local function on_attach(client, bufnr)
  mylsp.on_attach(client, bufnr)
end

rt.setup({
  server = {
    on_attach = on_attach,
    capabilities = mylsp.make_capabilities(),
  },
})
