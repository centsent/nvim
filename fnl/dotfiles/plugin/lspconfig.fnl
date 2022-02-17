(module :dotfiles.plugin.lspconfig
  {autoload {keymaps dotfiles.keymaps.lspconfig
             cmp-nvim-lsp cmp_nvim_lsp
             lspconfig lspconfig}})

(defn- update-capabilities []
  "Update the capabilities of the LSP clients."
  (var capabilities (vim.lsp.protocol.make_client_capabilities))
  (set capabilities (cmp-nvim-lsp.update_capabilities capabilities))
  capabilities)

(def- lsp_opt {:capabilities (update-capabilities)
                :flags {:debounce_text_change 150}
                :on_attach keymaps.custom-lsp-attach})

; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
(def- clients [:clangd 
               :gopls 
               :julials 
               :pyright 
               :rust_analyzer 
               :sumneko_lua 
               :tsserver])

(each [_ name (ipairs clients)]
  ((. lspconfig name :setup) lsp_opt))

;; Format on save.
(vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
