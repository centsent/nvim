(let [(has_lspconfig? lspconfig) (pcall require :lspconfig)]
  (when has_lspconfig?
    (local {: on_attach : make_capabilities} (require :me.lsp))

    (fn make_config []
      (local settings {:json {:validate {:eanble true}}})
      (let [(has_schemastore? schemastore) (pcall require :schemastore)]
        (when has_schemastore?
          (set settings.json.schemas (schemastore.json.schemas))))
      {: on_attach :capabilities (make_capabilities) : settings})

    (lspconfig.jsonls.setup (make_config))))

