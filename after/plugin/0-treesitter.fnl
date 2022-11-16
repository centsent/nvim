(let [(has_ts? ts) (pcall require :nvim-treesitter.configs)]
  (when has_ts?
    (local settings
           {:ensure_installed :all
            :highlight {:enable true}
            :rainbow {:enable true}
            :indent {:enable true}
            :autotag {:enable true}
            :context_commentstring {:enable true}
            :textobjects {:select {:enable true
                                   :keymaps {:ia "@attribute.inner"
                                             :iA "@attribute.outer"
                                             :ic "@conditional.inner"
                                             :iC "@conditional.outer"
                                             :if "@function.inner"
                                             :iF "@function.outer"
                                             :il "@loop.inner"
                                             :iL "@loop.outer"
                                             :ip "@parameter.inner"
                                             :iP "@parameter.outer"}}}})
    (ts.setup settings)
    (local parser_config ((. (require :nvim-treesitter.parsers)
                             :get_parser_configs)))
    (set parser_config.tsx.filetype_to_parsername [:javascript :typescript.tsx])
    (let [(has_context? context) (pcall require :treesitter-context)]
      (when has_context?
        (context.setup)))))

