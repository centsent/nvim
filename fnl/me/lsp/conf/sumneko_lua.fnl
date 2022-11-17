(let [(has_lspconfig? lspconfig) (pcall require :lspconfig)]
  (when has_lspconfig?
    (let [(has_neodev? neodev) (pcall require :neodev)]
      (when has_neodev?
        (neodev.setup)))
    (local {: on_attach : make_capabilities} (require :me.lsp))
    (local lua-settings {:Lua {:completion {:callSnippet :Replace}}})
    (lspconfig.sumneko_lua.setup {: on_attach
                                  :capabilities (make_capabilities)
                                  :settings lua-settings})))

