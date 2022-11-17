(let [(has-typescript? typescript) (pcall require :typescript)]
  (when has-typescript?
    (local {: on_attach : make_capabilities} (require :me.lsp))
    (typescript.setup {:server {: on_attach :capabilities (make_capabilities)}})))

