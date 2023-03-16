(fn on-new-config [new-config]
  (local json-schemas new-config.settings.json.schemas)
  (local schema-store (require :schemastore))
  (set new-config.settings.json.schemas (or json-schemas {}))
  (vim.list_extend json-schemas (schema-store.json.schemas)))

(local jsonls-settings
       {:on_new_config on-new-config
        :settings {:json {:format {:enable true} :validate {:enable true}}}})

{1 :neovim/nvim-lspconfig
 :dependencies [;; JSON schemas for Neovim
                :b0o/schemastore.nvim]
 :opts {:servers {:jsonls jsonls-settings}}}

