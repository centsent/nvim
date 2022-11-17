(let [(has_rt? rt) (pcall require :rust-tools)]
  (when has_rt?
    (local {: on_attach : make_capabilities} (require :me.lsp))

    (fn on-attach-rust [client bufnr]
      (on_attach client bufnr))

    (rt.setup {:server {:on_attach on-attach-rust
                        :capabilities (make_capabilities)}})))

