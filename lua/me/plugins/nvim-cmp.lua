-- :fennel:1678517326
local function config()
  local cmp = require("cmp")
  local cmp_sources = {{name = "nvim_lsp"}, {name = "nvim_lsp_signature_help"}, {name = "path"}, {name = "buffer"}, {name = "luasnip"}, {name = "nvim_lua"}}
  local cmp_mapping = {["<c-p>"] = cmp.mapping.select_prev_item(), ["<c-n>"] = cmp.mapping.select_next_item(), ["<c-d>"] = cmp.mapping.scroll_docs(-4), ["<c-u>"] = cmp.mapping.scroll_docs(4), ["<cr>"] = cmp.mapping.confirm({select = true}), ["<tab>"] = cmp.mapping.confirm({select = true})}
  local cmdline_confg = {[":"] = {sources = {{name = "cmdline"}}, mapping = cmp.mapping.preset.cmdline()}, ["/"] = {sources = {{name = "buffer"}}, mapping = cmp.mapping.preset.cmdline()}}
  local function setup_luasnip(args)
    local has_luasnip_3f, luasnip = pcall(require, "luasnip")
    if has_luasnip_3f then
      return luasnip.lsp_expand(args.body)
    else
      return nil
    end
  end
  local function setup_cmdline(settings)
    for cmd, config0 in pairs(settings) do
      local _local_2_ = config0
      local sources = _local_2_["sources"]
      local mapping = _local_2_["mapping"]
      cmp.setup.cmdline(cmd, {sources = sources, mapping = mapping})
    end
    return nil
  end
  local function setup_from_vscode()
    local has_from_vscode_3f, from_vscode = pcall(require, "luasnip.loaders.from_vscode")
    if has_from_vscode_3f then
      return from_vscode.lazy_load()
    else
      return nil
    end
  end
  local cmp_settings = {snippet = {expand = setup_luasnip}, sources = cmp.config.sources(cmp_sources), mapping = cmp.mapping.preset.insert(cmp_mapping), experimental = {ghost_text = true}}
  cmp.setup(cmp_settings)
  setup_cmdline(cmdline_confg)
  setup_from_vscode()
  return vim.api.nvim_set_option("completeopt", "menuone,noinsert,noselect")
end
return {event = "InsertEnter", config = config, dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lsp-signature-help", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets"}, "hrsh7th/nvim-cmp"}