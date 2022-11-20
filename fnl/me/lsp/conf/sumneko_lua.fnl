(let [(has_lspconfig? lspconfig) (pcall require :lspconfig)]
  (when has_lspconfig?
    (let [(has_neodev? neodev) (pcall require :neodev)]
      (when has_neodev?
        (neodev.setup)))
    (local {: config} (require :me.lsp))
    (local settings {:Lua {:completion {:callSnippet :Replace}}})
    (lspconfig.sumneko_lua.setup (config {: settings}))))

