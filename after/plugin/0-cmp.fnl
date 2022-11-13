(let [(has_cmp? cmp) (pcall require :cmd)]
  (when has_cmp?
    (cmp.setup {
      :snippet {
        :expand (lambda [args]
          (let [(has_luasnip? luasnip) (pcall require :luasnip)]
            (when has_luasnip?
              (luasnip.lsp_expand args.body))))
      }
      :sources (cmp.config.sources [ 
        {:name "nvim_lsp"}
        {:name "nvim_lsp_signature_help"}
        {:name "path"}
        {:name "buffer"}
        {:name "luasnip"}
        {:name "nvim_lua"}
      ])
      :mapping (cmp.mapping.preset.insert {
        :<c-p> (cmp.mapping.select_prev_item)
        :<c-n> (cmp.mapping.select_next_item)
        :<c-d> (cmp.mapping.scroll_docs -4)
        :<c-u> (cmp.mapping.scroll_docs 4)
        :<cr>  (cmp.mapping.confirm { :select true })
        :<tab> (cmp.mapping.confirm { :select true })

      })
      :experimental { :ghost_text true }
    })

    (cmp.setup.cmdline "/" {
      :sources { :name "buffer" }
      :mapping (cmp.mapping.preset.cmdline)
    })
    (cmp.setup.cmdline ":" {
      :sources { :name "cmdline" }
      :mapping (cmp.mapping.preset.cmdline)
    })

    (let [(has_from_vscode? from_vscode) (pcall require "luasnip.loaders.from_vscode")]
      (when has_from_vscode?
        (from_vscode.lazy_load)))

    (vim.api.nvim_set_option "completeopt" "menuone,noinsert,noselect")))
