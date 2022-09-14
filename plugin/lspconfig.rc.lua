local safe_require = require("utils").safe_require
local has_lspconfig, lspconfig = safe_require("lspconfig")
if not has_lspconfig then
  return
end

local lsp = require("me.lsp")
local servers = lsp.get_servers()

-- Diagnostic symbols in the sign column (gutter)
lsp.setup_signs()

local setup = function(name)
  local ok, _ = safe_require("me.lsp.conf." .. name)

  if not ok then
    local default_config = lsp.get_default_config()
    lspconfig[name].setup(default_config)
  end
end

-- Setup lsp servers
for _, name in ipairs(servers) do
  setup(name)
end
