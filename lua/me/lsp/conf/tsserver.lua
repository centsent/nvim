local utils = require("utils")
local has_typescript, typescript = utils.safe_require("typescript")
if not has_typescript then
  return
end

local mylsp = require("me.lsp")
typescript.setup({
  server = {
    on_attach = mylsp.on_attach,
    capabilities = mylsp.make_capabilities(),
  },
})
