local has_mason, mason = pcall(require, "mason")
if not has_mason then
  return
end

local has_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if not has_mason_lsp then
  return
end

mason.setup({
  max_concurrent_installers = 10,
})

mason_lsp.setup({
  ensure_installed = require("me.lsp").get_servers(),
  automatic_installation = true,
})
