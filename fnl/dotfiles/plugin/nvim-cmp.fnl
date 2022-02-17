(module dotfiles.plugin.nvim-cmp
  {autoload {cmp cmp
             luasnip luasnip}})

; Snippet sources
(def- sources [{:name "nvim_lsp"}
               {:name "luasnip"}])

; Keymap for snippets.
(def- mapping {:<c-p> (cmp.mapping.select_prev_item)
               :<c-n> (cmp.mapping.select_next_item)
               :<c-d> (cmp.mapping.scroll_docs -4)
               :<c-u> (cmp.mapping.scroll_docs 4)
               :<cr> (cmp.mapping.confirm {:select true})
               :<tab> (cmp.mapping.confirm {:select true})})

(defn- lsp_expand [args]
  "Expand the current selection to the nearest symbol."
  (luasnip.lsp_expand args.body))

; Setup nvim-cmp.
(cmp.setup {:snippet {:expand lsp_expand}
            :mapping mapping
            :sources sources})
