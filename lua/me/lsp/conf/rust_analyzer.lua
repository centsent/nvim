local utils = require("utils")
local has_rt, rt = utils.safe_require("rust-tools")
if not has_rt then
  return
end

local mylsp = require("me.lsp")

rt.setup({
  server = {
    on_attach = mylsp.on_attach,
    capabilities = mylsp.make_capabilities(),
  },
})
