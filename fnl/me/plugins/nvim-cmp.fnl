(fn config []
  (local cmp (require :cmp))
  (local cmp-sources [{:name :nvim_lsp}
                      {:name :nvim_lsp_signature_help}
                      {:name :path}
                      {:name :buffer}
                      {:name :luasnip}
                      {:name :nvim_lua}])
  (local cmp-mapping
         {:<c-p> (cmp.mapping.select_prev_item)
          :<c-n> (cmp.mapping.select_next_item)
          :<c-d> (cmp.mapping.scroll_docs -4)
          :<c-u> (cmp.mapping.scroll_docs 4)
          :<cr> (cmp.mapping.confirm {:select true})
          :<tab> (cmp.mapping.confirm {:select true})})
  (local cmdline-confg
         {":" {:sources [{:name :cmdline}]
               :mapping (cmp.mapping.preset.cmdline)}
          :/ {:sources [{:name :buffer}] :mapping (cmp.mapping.preset.cmdline)}})

  (fn setup-luasnip [args]
    (let [(has-luasnip? luasnip) (pcall require :luasnip)]
      (when has-luasnip?
        (luasnip.lsp_expand args.body))))

  (fn setup-cmdline [settings]
    (each [cmd config (pairs settings)]
      (local {: sources : mapping} config)
      (cmp.setup.cmdline cmd {: sources : mapping})))

  (fn setup-from-vscode []
    (let [(has-from-vscode? from-vscode) (pcall require
                                                :luasnip.loaders.from_vscode)]
      (when has-from-vscode?
        (from-vscode.lazy_load))))

  (local cmp-settings {:snippet {:expand setup-luasnip}
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
                ;; Snippet Engine for Neovim written in Lua.
                :L3MON4D3/LuaSnip
                ;; luasnip completion source for nvim-cmp
                :saadparwaiz1/cmp_luasnip
                ;; Set of preconfigured snippets for different languages.
                :rafamadriz/friendly-snippets]}

