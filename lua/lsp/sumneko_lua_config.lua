local M = {}

M.make_config = function()
  local config = require("lua-dev").setup({
    runtime_path = true,
    library = {
      vimruntime = true,
      types = true,
      plugins = true,
    },
    lspconfig = {
      runtime = { version = "LuaJIT" },
      global = {'vim'},
    },
  })

  return config
end

return M
