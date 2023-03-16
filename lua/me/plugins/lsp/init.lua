-- :fennel:1678976761
local function config(_, settings)
  local util = require("me.util")
  local function _1_(client, buffer)
    local keymaps = require("me.plugins.lsp.keymaps")
    return keymaps["on-attach"](client, buffer)
  end
  util["on-attach"](_1_)
  local function get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp = require("cmp_nvim_lsp")
    return cmp.default_capabilities(capabilities)
  end
  local servers = settings.servers
  local capabilities = get_capabilities()
  local function setup(server)
    local old_opts = {capabilities = vim.deepcopy(capabilities)}
    local new_opts = (servers[server] or {})
    local server_opts = vim.tbl_deep_extend("force", old_opts, new_opts)
    local server_setup = settings.setup[server]
    if server_setup then
      pcall(server_setup, server, server_opts)
    else
    end
    local lspconfig = require("lspconfig")
    return lspconfig[server].setup(server_opts)
  end
  local function setup_mason_lsp()
    local ensure_installed = {}
    for server, server_opts in pairs(servers) do
      if server_opts then
        ensure_installed[(#ensure_installed + 1)] = server
      else
      end
    end
    local mlsp = require("mason-lspconfig")
    mlsp.setup({ensure_installed = ensure_installed})
    return mlsp.setup_handlers({setup})
  end
  return setup_mason_lsp()
end
local dependencies = {{opts = {max_concurrent_installers = 10}, "williamboman/mason.nvim"}, "williamboman/mason-lspconfig.nvim", "j-hui/fidget.nvim", "SmiteshP/nvim-navic", "ray-x/lsp_signature.nvim", "mfussenegger/nvim-jdtls"}
return {opts = {autoformat = true, setup = {}, servers = {bashls = {}, clangd = {}, csharp_ls = {}, cssls = {}, cmake = {}, dockerls = {}, fennel_language_server = {settings = {fennel = {diagnostics = {globals = {"vim"}}}}}, gopls = {}, html = {}, julials = {}, marksman = {}, pyright = {}, solargraph = {}, taplo = {}, vimls = {}, volar = {}}}, config = config, dependencies = dependencies, event = {"BufReadPost", "BufNewFile"}, "neovim/nvim-lspconfig"}