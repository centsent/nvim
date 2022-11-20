(let [(has-typescript? typescript) (pcall require :typescript)]
  (when has-typescript?
    (local {: config} (require :me.lsp))
    (typescript.setup {:server (config)})))

