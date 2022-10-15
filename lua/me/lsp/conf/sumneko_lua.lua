local safe_require = require("utils").safe_require

local make_config = function()
  local has_neodev, neodev = safe_require("neodev")
  if not has_neodev then
    return {}
  end

  local config = neodev.setup({
    runtime_path = true,
    library = {
      vimruntime = true,
      types = true,
      plugins = true,
    },
    lspconfig = {
      runtime = { version = "LuaJIT" },
      global = { "vim" },
    },
  })

  return config
end

require("me.lsp").setup_with_config("sumneko_lua", make_config())
