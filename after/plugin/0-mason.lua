-- :fennel:1668308816
do
  local has_mason_3f, mason = pcall(require, "mason")
  if has_mason_3f then
    mason.setup({max_concurrent_installers = 10})
  else
  end
end
local has_mason_lsp_3f, mason_lsp = pcall(require, "mason-lspconfig")
if has_mason_lsp_3f then
  return mason_lsp.setup({ensure_installed = (require("me.lsp")).get_servers(), automatic_installation = true})
else
  return nil
end