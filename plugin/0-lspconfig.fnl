(let [(has_lspconfig? lspconfig) (pcall require :lspconfig)]
  (when has_lspconfig?
    (local mylsp (require :me.lsp))
    (local servers (mylsp.get_servers))
    (fn setup [name]
      (let [(ok? _) (pcall require (.. "me.lsp.conf." name) )]
        (when (not ok?)
          ((. lspconfig name :setup) {
            :on_attach mylsp.on_attach
            :capabilities mylsp.capabilities
          }))))
    
    (each [_ name (ipairs servers)]
      (setup name))))
