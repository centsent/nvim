(let [(has_mason? mason) (pcall require :mason)]
  (when has_mason?
    (mason.setup { :max_concurrent_installers 10 })))

(let [(has_mason_lsp? mason_lsp) (pcall require :mason-lspconfig)]
  (when has_mason_lsp?
    (mason_lsp.setup {
      :ensure_installed ((. (require :mason-lspconfig) :get_servers))
      :automatic_installation true
    })))
