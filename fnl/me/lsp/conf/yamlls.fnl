(let [(has_lspconfig? lspconfig) (pcall require :lspconfig)]
  (when has_lspconfig?
    (local {: config} (require :me.lsp))

    (fn make_config []
      (local settings {:yaml {:hover true :completion true :validate true}})
      (let [(has_schemastore? schemastore) (pcall require :schemastore)]
        (when has_schemastore?
          (set settings.yaml.schemas (schemastore.json.schemas))))
      (config {: settings}))

    (lspconfig.yamlls.setup (make_config))))

