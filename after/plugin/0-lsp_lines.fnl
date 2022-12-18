(let [(has-lsp-lines? lsp-lines) (pcall require :lsp_lines)]
  (when has-lsp-lines?
    (vim.diagnostic.config {:virtual_text false})
    (vim.keymap.set :n :<leader>l #(lsp-lines.toggle))
    (lsp-lines.setup)))

