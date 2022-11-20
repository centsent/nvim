(let [(has_ts? ts) (pcall require :nvim-treesitter.configs)]
  (when has_ts?
    (local textobjects {:select {:enable true}})
    (set textobjects.select.keymaps
         {:ia "@attribute.inner"
          :iA "@attribute.outer"
          :ic "@conditional.inner"
          :iC "@conditional.outer"
          :if "@function.inner"
          :iF "@function.outer"
          :il "@loop.inner"
          :iL "@loop.outer"
          :ip "@parameter.inner"
          :iP "@parameter.outer"})
    (local settings {:ensure_installed :all
                     :highlight {:enable true}
                     :rainbow {:enable true}
                     :indent {:enable true}
                     :autotag {:enable true}
                     :context_commentstring {:enable true}
                     : textobjects})
    (ts.setup settings)

    (fn update-parser-configs []
      (local {: get_parser_configs} (require :nvim-treesitter.parsers))
      (local parser-config (get_parser_configs))
      (set parser-config.tsx.filetype_to_parsername
           [:javascript :typescript.tsx]))

    (fn setup-context []
      (let [(has-context? context) (pcall require :treesitter-context)]
        (when has-context?
          (context.setup))))

    (update-parser-configs)
    (setup-context)))

