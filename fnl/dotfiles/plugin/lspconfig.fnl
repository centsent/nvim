(module :dotfiles.plugin.lspconfig
  {autoload {keymaps dotfiles.keymaps.lspconfig
             cmp-nvim-lsp cmp_nvim_lsp
             lspconfig lspconfig
             util dotfiles.util}})


(defn- update-capabilities []
  "Update the capabilities of the LSP clients."
  (var capabilities (vim.lsp.protocol.make_client_capabilities))
  (set capabilities (cmp-nvim-lsp.update_capabilities capabilities))
  capabilities)

(def- lsp_opt {:capabilities (update-capabilities)
               :flags {:debounce_text_change 150}
               :on_attach keymaps.custom-lsp-attach})

(def- lua_lsp_opt {:diagnostics {:globals ["vim"]}
                   :runtime {:version "LuaJIT"}})

(def- sumneko_lua_setup {:settings {:Lua lua_lsp_opt}})

; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
(def- clients {:clangd {}
               :csharp_ls {}
               :gopls {}
               :golangci_lint_ls {}
               :julials {}
               :phpactor {}
               :pyright {}
               :rust_analyzer {}
               :sumneko_lua sumneko_lua_setup
               :tsserver {}})

(each [name opt (pairs clients)]
  ((. lspconfig name :setup) (util.merge_tables lsp_opt opt)))
