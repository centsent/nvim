(let [(has_rt? rt) (pcall require :rust-tools)]
  (when has_rt?
    (local {: config : on_attach} (require :me.lsp))

    (fn on-attach-rust [client bufnr]
      (on_attach client bufnr))

    (local settings {:server (config)})
    (rt.setup settings)))

