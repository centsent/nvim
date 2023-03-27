(fn setup-luasnip [args]
  (local luasnip (require :luasnip))
  (luasnip.lsp_expand args.body))

(fn setup-from-vscode []
  (local from-vscode (require :luasnip.loaders.from_vscode))
  (from-vscode.lazy_load))

(fn config [_ _]
  (local cmp (require :cmp))
  (local lspkind (require :lspkind))
  (local cmp-sources [{:name :nvim_lsp}
                      {:name :nvim_lsp_signature_help}
                      {:name :path}
                      {:name :buffer}
                      {:name :luasnip}
                      {:name :nvim_lua}
                      {:name :codeium}])
  (local cmp-mapping
         {:<c-p> (cmp.mapping.select_prev_item)
          :<c-n> (cmp.mapping.select_next_item)
          :<c-d> (cmp.mapping.scroll_docs -4)
          :<c-u> (cmp.mapping.scroll_docs 4)
          :<tab> (cmp.mapping.confirm {:select true})})
  (local cmdline-confg
         {":" {:sources [{:name :path}
                         {:name :cmdline}
                         {:name :cmdline_history}]
               :mapping (cmp.mapping.preset.cmdline)}
          :/ {:sources [{:name :buffer} {:name :cmdline_history}]
              :mapping (cmp.mapping.preset.cmdline)}})

  (fn setup-cmdline [settings]
    (each [cmd config (pairs settings)]
      (local {: sources : mapping} config)
      (cmp.setup.cmdline cmd {: sources : mapping})))

  (local lspkind-format (lspkind.cmp_format {:mode :symbol_text}))
  (local cmp-settings {:snippet {:expand setup-luasnip}
                       :formatting {:format lspkind-format}
                       :sources (cmp.config.sources cmp-sources)
                       :mapping (cmp.mapping.preset.insert cmp-mapping)
                       :experimental {:ghost_text true}})
  (cmp.setup cmp-settings)
  (setup-cmdline cmdline-confg)
  (setup-from-vscode)
  (vim.api.nvim_set_option :completeopt "menuone,noinsert,noselect"))

{1 :hrsh7th/nvim-cmp
 :event :InsertEnter
 : config
 :dependencies [;; nvim-cmp source for buffer words
                :hrsh7th/cmp-buffer
                ;; nvim-cmp source for neovim builtin LSP client
                :hrsh7th/cmp-nvim-lsp
                ;; nvim-cmp source for displaying function signatures with the current parameter emphasized:
                :hrsh7th/cmp-nvim-lsp-signature-help
                ;; nvim-cmp source for path
                :hrsh7th/cmp-path
                ;; nvim-cmp source for vim's cmdline
                :hrsh7th/cmp-cmdline
                ;; Source for nvim-cmp which reads results from command-line or search histories
                :dmitmel/cmp-cmdline-history
                ;; Snippet Engine for Neovim written in Lua.
                :L3MON4D3/LuaSnip
                ;; luasnip completion source for nvim-cmp
                :saadparwaiz1/cmp_luasnip
                ;; Set of preconfigured snippets for different languages.
                :rafamadriz/friendly-snippets
                ;; vscode-like pictograms for neovim lsp completion items
                {1 :onsails/lspkind.nvim
                 :opts {:symbol_map (. (require :me.config) :icons :kinds)}
                 :config (fn [_ opts]
                           (local lspkind (require :lspkind))
                           (lspkind.init opts))}]}

