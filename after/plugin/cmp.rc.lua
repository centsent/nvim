local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

local from_vscode = require("luasnip.loaders.from_vscode")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "luasnip" },
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
})

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
from_vscode.lazy_load()
