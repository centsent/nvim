(let [(has-phpactor? phpactor) (pcall require :phpactor)]
  (when has-phpactor?
    (local {: on_attach : make_capabilities} (require :me.lsp))
    (local phpactor-path (.. (vim.fn.stdpath :data) :/mason/packages/phpactor))
    (local settings
           {:install {:path phpactor-path
                      :bin (.. phpactor-path :/bin/phpactor)}
            :lspconfig {:options {: on_attach
                                  :capabilities (make_capabilities)}}})
    (phpactor.setup settings)))

