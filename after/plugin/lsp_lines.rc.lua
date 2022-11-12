local has_lsplines, lsplines = pcall(require, "lsp_lines")
if not has_lsplines then
  return
end

vim.diagnostic.config({
  virtual_text = false,
})
lsplines.setup()
