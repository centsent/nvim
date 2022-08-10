(module :dotfiles.plugin.lspconfig
  {autoload {keymaps dotfiles.keymaps.lspconfig
             cmp_nvim_lsp cmp_nvim_lsp
             lspconfig lspconfig
             mason mason
             mason_lspconfig mason-lspconfig
             lua_dev lua-dev
             util dotfiles.util}})

(defn- update-capabilities []
  "Update the capabilities of the LSP clients."
  (var capabilities (vim.lsp.protocol.make_client_capabilities))
  (set capabilities (cmp_nvim_lsp.update_capabilities capabilities))
  capabilities)

(def- lsp_opt {:capabilities (update-capabilities)
               :flags {:debounce_text_change 150}
               :on_attach keymaps.custom-lsp-attach})

(def- luadev (lua_dev.setup {:runtime_path true
                             :lspconfig {:runtime {:version "LuaJIT"}}}))

; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
(def- clients {:clangd {}
               :csharp_ls {}
               :cssls {}
               :cmake {}
               :gopls {}
               :golangci_lint_ls {}
               :html {}
               :jsonls {}
               :julials {}
               :phpactor {}
               :pyright {}
               :rust_analyzer {}
               :sumneko_lua luadev
               :tsserver {}
               :vuels {}})

(each [name opt (pairs clients)]
  ((. lspconfig name :setup) (vim.tbl_deep_extend "force" lsp_opt opt)))

(mason.setup {:max_concurrent_installers 10})
(mason_lspconfig.setup {:automatic_installation true})
