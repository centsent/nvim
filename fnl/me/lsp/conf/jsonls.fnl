(let [(has_lspconfig? lspconfig) (pcall require :lspconfig)]
  (when has_lspconfig?
    (local mylsp (require :me.lsp))

    (fn make_config []
      (local settings {:json {:validate {:eanble true}}})
      (let [(has_schemastore? schemastore) (pcall require :schemastore)]
        (when has_schemastore?
          (set settings.json.schemas (schemastore.json.schemas))))
      {:on_attach mylsp.on_attach :capabilities mylsp.capabilities : settings})

    (lspconfig.jsonls.setup (make_config))))

