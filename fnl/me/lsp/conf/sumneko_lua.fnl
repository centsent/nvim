(let [(has_lspconfig? lspconfig) (pcall require :lspconfig)]
  (when has_lspconfig?
    (let [(has_neodev? neodev) (pcall require :neodev)]
      (when has_neodev?
        (neodev.setup)))

    (local mylsp (require :me.lsp))
    (lspconfig.sumneko_lua.setup {
      :on_attach mylsp.on_attach
      :capabilities (mylsp.make_capabilities)
      :settings {
        :Lua {
          :completion {
            :callSnippet "Replace"
          }
        }
      }
    })))

