(module dotfiles.plugin.mason
  {autoload {mason mason
             mason_lspconfig mason-lspconfig}})

(mason.setup {:max_concurrent_installers 10})
(mason_lspconfig.setup {:automatic_installation true})
