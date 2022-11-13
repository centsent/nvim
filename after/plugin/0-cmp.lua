-- :fennel:1668302318
local has_cmp_3f, cmp = pcall(require, "cmd")
if has_cmp_3f then
  local function _1_(args)
    _G.assert((nil ~= args), "Missing argument args on plugin/0-cmp.fnl:5")
    local has_luasnip_3f, luasnip = pcall(require, "luasnip")
    if has_luasnip_3f then
      return luasnip.lsp_expand(args.body)
    else
      return nil
    end
  end
  cmp.setup({snippet = {expand = _1_}, sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "nvim_lsp_signature_help"}, {name = "path"}, {name = "buffer"}, {name = "luasnip"}, {name = "nvim_lua"}}), mapping = cmp.mapping.preset.insert({["<c-p>"] = cmp.mapping.select_prev_item(), ["<c-n>"] = cmp.mapping.select_next_item(), ["<c-d>"] = cmp.mapping.scroll_docs(-4), ["<c-u>"] = cmp.mapping.scroll_docs(4), ["<cr>"] = cmp.mapping.confirm({select = true}), ["<tab>"] = cmp.mapping.confirm({select = true})}), experimental = {ghost_text = true}})
  cmp.setup.cmdline("/", {sources = {name = "buffer"}, mapping = cmp.mapping.preset.cmdline()})
  cmp.setup.cmdline(":", {sources = {name = "cmdline"}, mapping = cmp.mapping.preset.cmdline()})
  do
    local has_from_vscode_3f, from_vscode = pcall(require, "luasnip.loaders.from_vscode")
    if has_from_vscode_3f then
      from_vscode.lazy_load()
    else
    end
  end
  return vim.api.nvim_set_option("completeopt", "menuone,noinsert,noselect")
else
  return nil
end