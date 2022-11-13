-- :fennel:1668303028
local has_lsp_lines_3f, lsp_lines = pcall(require, "lsp_lines")
if has_lsp_lines_3f then
  vim.diagnostic.config({virtual_text = false})
  return lsp_lines.setup()
else
  return nil
end