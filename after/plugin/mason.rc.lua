local ok, mason = pcall(require, "mason")
if not ok then
  return
end

local mason_lsp_on, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_on then
  return
end

mason.setup({
  max_concurrent_installers = 10,
})

mason_lspconfig.setup({
  automatic_installation = true,
})
