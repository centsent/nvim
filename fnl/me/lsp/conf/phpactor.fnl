(let [(has-phpactor? phpactor) (pcall require :phpactor)]
  (when has-phpactor?
    (local {: config} (require :me.lsp))
    (local phpactor-path (.. (vim.fn.stdpath :data) :/mason/packages/phpactor))
    (local settings {:install {:path phpactor-path
                               :bin (.. phpactor-path :/bin/phpactor)}
                     :lspconfig {:options (config)}})
    (phpactor.setup settings)))

