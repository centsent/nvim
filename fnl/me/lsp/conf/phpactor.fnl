(let [(has_phpactor? phpactor) (pcall require :phpactor)]
  (when has_phpactor?
    (local mylsp (require :me.lsp))
    (local phpactor_path (.. (vim.fn.stdpath "data") "/mason/packages/phpactor"))
    (local settings {
      :install {
        :path phpactor_path
        :bin (.. phpactor_path "/bin/phpactor")
      }
      :lspconfig {
        :options {
          :on_attach mylsp.on_attach
          :capabilities (mylsp.make_capabilities)
        }
      }
    })
    (phpactor.setup settings)))