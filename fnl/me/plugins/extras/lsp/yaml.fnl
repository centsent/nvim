(fn on-new-config [new-config]
  (local json-schemas new-config.settings.json.schemas)
  (local schema-store (require :schemastore))
  (set new-config.settings.yaml.schemas (or json-schemas {}))
  (vim.list_extend json-schemas (schema-store.yaml.schemas)))

(local yamlls-settings
       {:on_new_config on-new-config
        :settings {:yaml {:hover true :completion true :validate true}}})

{1 :neovim/nvim-lspconfig
 :dependencies [;; JSON schemas for Neovim
                :b0o/schemastore.nvim]
 :opts {:servers {:yamlls yamlls-settings}}}

