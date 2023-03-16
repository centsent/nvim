(fn setup-phpactor [_ opts]
  (local phpactor (require :phpactor))
  (local phpactor-path (.. (vim.fn.stdpath :data) :/mason/packages/phpactor))
  (local settings {:install {:path phpactor-path
                             :bin (.. phpactor-path :/bin/phpactor)}
                   :lspconfig {:options opts}})
  (phpactor.setup settings))

{1 :neovim/nvim-lspconfig
 :dependencies [;; Lua version of phpactor nvim plugin
                :gbprod/phpactor.nvim]
 :opts {:phpactor {} :setup {:phpactor setup-phpactor}}}

