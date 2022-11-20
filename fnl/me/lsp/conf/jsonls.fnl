(let [(has_lspconfig? lspconfig) (pcall require :lspconfig)]
  (when has_lspconfig?
    (local {: config} (require :me.lsp))

    (fn make-config []
      (local settings {:json {:validate {:enable true}}})
      (let [(has_schemastore? schemastore) (pcall require :schemastore)]
        (when has_schemastore?
          (set settings.json.schemas (schemastore.json.schemas))))
      (config {: settings}))

    (lspconfig.jsonls.setup (make-config))))

