(let [(has_lsp_lines? lsp_lines) (pcall require :lsp_lines)]
  (when has_lsp_lines?
    (vim.diagnostic.config { :virtual_text false })
    (lsp_lines.setup)))
