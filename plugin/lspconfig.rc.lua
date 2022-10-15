local safe_require = require("utils").safe_require
local has_lspconfig, lspconfig = safe_require("lspconfig")
if not has_lspconfig then
  return
end

local mylsp = require("me.lsp")
local servers = mylsp.get_servers()

-- Diagnostic symbols in the sign column
mylsp.setup_signs()

local setup = function(name)
  local ok, _ = safe_require("me.lsp.conf." .. name)

  if not ok then
    lspconfig[name].setup({
      on_attach = mylsp.on_attach,
      capabilities = mylsp.make_capabilities(),
    })
  end
end

-- Setup lsp servers
for _, name in ipairs(servers) do
  setup(name)
end
