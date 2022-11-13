(let [(has_rt? rt) (pcall require :rust-tools)]
  (when has_rt?
    (local mylsp (require :me.lsp))
    (fn on_attach [client bufnr]
      (mylsp.on_attach client bufnr))

    (rt.setup {
      :server {
        : on_attach
        :capabilities (mylsp.make_capabilities)
      }
    })))
