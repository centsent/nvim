(let [(has-cmp? cmp) (pcall require :cmp)]
  (when has-cmp?
    (local cmp-sources [{:name :nvim_lsp}
                        {:name :nvim_lsp_signature_help}
                        {:name :path}
                        {:name :buffer}
                        {:name :luasnip}
                        {:name :nvim_lua}
                        {:name :cmp_tabnine}])
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
            :/ {:sources [{:name :buffer}]
                :mapping (cmp.mapping.preset.cmdline)}})

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

    (fn setup-tabnine []
      (let [(has-tabnine? tabnine) (pcall require :cmp_tabnine.config)]
        (when has-tabnine?
          (tabnine:setup {}))))

    (local cmp-settings
           {:snippet {:expand setup-luasnip}
            :sources (cmp.config.sources cmp-sources)
            :mapping (cmp.mapping.preset.insert cmp-mapping)
            :experimental {:ghost_text true}})
    (cmp.setup cmp-settings)
    (setup-cmdline cmdline-confg)
    (setup-from-vscode)
    (setup-tabnine)
    (vim.api.nvim_set_option :completeopt "menuone,noinsert,noselect")))

