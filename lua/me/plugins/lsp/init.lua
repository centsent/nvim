-- :fennel:1679552665
local function set_diagnostics_icons(icons)
  for type, icon in pairs(icons) do
    local name = ("DiagnosticSign" .. type)
    vim.fn.sign_define(name, {text = icon, texthl = name, numhl = name})
  end
  return nil
end
local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp = require("cmp_nvim_lsp")
  return cmp.default_capabilities(capabilities)
end
local function config(_, settings)
  local servers = settings.servers
  local function on_attach(client, buffer)
    local keymaps = require("me.plugins.lsp.keymaps")
    local format = require("me.plugins.lsp.format")
    keymaps["on-attach"](client, buffer)
    format["on-attach"](client, buffer)
    if client.server_capabilities.documentSymbolProvider then
      local navic = require("nvim-navic")
      return navic.attach(client, buffer)
    else
      return nil
    end
  end
  local function setup(server)
    local capabilities = get_capabilities()
    local old_opts = {capabilities = vim.deepcopy(capabilities)}
    local new_opts = (servers[server] or {})
    local server_opts = vim.tbl_deep_extend("force", old_opts, new_opts)
    local setup_server = settings.setup[server]
    if setup_server then
      pcall(setup_server, server, server_opts)
    else
    end
    local lspconfig = require("lspconfig")
    return lspconfig[server].setup(server_opts)
  end
  local function setup_mason_lsp()
    local ensure_installed = {}
    local mlsp = require("mason-lspconfig")
    for server, server_opts in pairs(servers) do
      if server_opts then
        local available = mlsp.get_available_servers()
        local is_not_mason_server = ((server_opts.mason ~= false) and not vim.tbl_contains(available, server))
        if is_not_mason_server then
          setup(server)
        else
          ensure_installed[(#ensure_installed + 1)] = server
        end
      else
      end
    end
    mlsp.setup({ensure_installed = ensure_installed})
    return mlsp.setup_handlers({setup})
  end
  do end (require("me.util"))["on-attach"](on_attach)
  set_diagnostics_icons((require("me.config")).icons.diagnostics)
  return setup_mason_lsp()
end
local dependencies = {{opts = {max_concurrent_installers = 10}, "williamboman/mason.nvim"}, "williamboman/mason-lspconfig.nvim", "j-hui/fidget.nvim", "SmiteshP/nvim-navic", {config = true, "ray-x/lsp_signature.nvim"}, "mfussenegger/nvim-jdtls"}
return {{opts = {autoformat = true, setup = {}, servers = {bashls = {}, clangd = {}, csharp_ls = {}, cssls = {}, cmake = {}, dockerls = {}, fennel_language_server = {settings = {fennel = {diagnostics = {globals = {"vim"}}}}, mason = false}, html = {}, julials = {}, marksman = {}, pyright = {}, solargraph = {}, taplo = {}, vimls = {}, volar = {}}}, config = config, dependencies = dependencies, event = {"BufReadPost", "BufNewFile"}, "neovim/nvim-lspconfig"}, {import = "me.plugins.extras.lsp"}}