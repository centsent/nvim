(let [(has_lspconfig? lspconfig) (pcall require :lspconfig)]
  (when has_lspconfig?
    (local {: config : get_servers} (require :me.lsp))
    (local servers (get_servers))

    (fn setup [name]
      (let [(ok? _) (pcall require (.. :me.lsp.conf. name))]
        (when (not ok?)
          ((. lspconfig name :setup) (config)))))

    (each [_ name (ipairs servers)]
      (setup name))))

