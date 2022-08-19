local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      local has_luasnip, luasnip = pcall(require, "luasnip")
      if has_luasnip then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "path" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "path" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<c-p>"] = cmp.mapping.select_prev_item(),
    ["<c-n>"] = cmp.mapping.select_next_item(),
    ["<c-d>"] = cmp.mapping.scroll_docs(-4),
    ["<c-u>"] = cmp.mapping.scroll_docs(4),
    ["<cr>"] = cmp.mapping.confirm({ select = true }),
    ["<tab>"] = cmp.mapping.confirm({ select = true }),
  }),
  experimental = {
    ghost_text = true,
  },
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
  mapping = cmp.mapping.preset.cmdline(),
})

cmp.setup.cmdline(":", {
  sources = {
    { name = "cmdline" },
  },
  mapping = cmp.mapping.preset.cmdline(),
})

local has_from_vscode, from_vscode = pcall(require, "luasnip.loaders.from_vscode")
if has_from_vscode then
  from_vscode.lazy_load()
end

vim.api.nvim_set_option("completeopt", "menuone,noinsert,noselect")
