(let [(has_typescript? typescript) (pcall require :typescript)]
  (when has_typescript?
    (local mylsp (require :me.lsp))
    (typescript.setup {:server {:on_attach mylsp.on_attach
                                :capabilities (mylsp.make_capabilities)}})))

