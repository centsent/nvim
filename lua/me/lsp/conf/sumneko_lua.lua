local make_config = function()
  local has_lua_dev, lua_dev = pcall(require, "lua-dev")
  if not has_lua_dev then
    return {}
  end

  local config = lua_dev.setup({
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

require("me.lsp").extend_config("sumneko_lua", make_config())
