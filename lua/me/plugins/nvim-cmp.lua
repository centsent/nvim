-- :fennel:1679892842
local function setup_luasnip(args)
  local luasnip = require("luasnip")
  return luasnip.lsp_expand(args.body)
end
local function setup_from_vscode()
  local from_vscode = require("luasnip.loaders.from_vscode")
  return from_vscode.lazy_load()
end
local function config(_, _0)
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local cmp_sources = {{name = "nvim_lsp"}, {name = "nvim_lsp_signature_help"}, {name = "path"}, {name = "buffer"}, {name = "luasnip"}, {name = "nvim_lua"}, {name = "codeium"}}
  local cmp_mapping = {["<c-p>"] = cmp.mapping.select_prev_item(), ["<c-n>"] = cmp.mapping.select_next_item(), ["<c-d>"] = cmp.mapping.scroll_docs(-4), ["<c-u>"] = cmp.mapping.scroll_docs(4), ["<tab>"] = cmp.mapping.confirm({select = true})}
  local cmdline_confg = {[":"] = {sources = {{name = "path"}, {name = "cmdline"}, {name = "cmdline_history"}}, mapping = cmp.mapping.preset.cmdline()}, ["/"] = {sources = {{name = "buffer"}, {name = "cmdline_history"}}, mapping = cmp.mapping.preset.cmdline()}}
  local function setup_cmdline(settings)
    for cmd, config0 in pairs(settings) do
      local _local_1_ = config0
      local sources = _local_1_["sources"]
      local mapping = _local_1_["mapping"]
      cmp.setup.cmdline(cmd, {sources = sources, mapping = mapping})
    end
    return nil
  end
  local lspkind_format = lspkind.cmp_format({mode = "symbol_text"})
  local cmp_settings = {snippet = {expand = setup_luasnip}, formatting = {format = lspkind_format}, sources = cmp.config.sources(cmp_sources), mapping = cmp.mapping.preset.insert(cmp_mapping), experimental = {ghost_text = true}}
  cmp.setup(cmp_settings)
  setup_cmdline(cmdline_confg)
  setup_from_vscode()
  return vim.api.nvim_set_option("completeopt", "menuone,noinsert,noselect")
end
local function _2_(_, opts)
  local lspkind = require("lspkind")
  return lspkind.init(opts)
end
return {event = "InsertEnter", config = config, dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lsp-signature-help", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "dmitmel/cmp-cmdline-history", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets", {opts = {symbol_map = (require("me.config")).icons.kinds}, config = _2_, "onsails/lspkind.nvim"}}, "hrsh7th/nvim-cmp"}