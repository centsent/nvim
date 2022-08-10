(module dotfiles.plugin.treesitter
  {autoload {ts nvim-treesitter
             tsconfigs nvim-treesitter.configs
             parsers nvim-treesitter.parsers}})

(defn- folding []
  ; Code folding with treesitter
  (vim.cmd "set foldmethod=expr")
  (vim.cmd "set foldexpr=nvim_treesitter#foldexpr()")
  ; recompute folds
  (vim.cmd "normal zx"))

(ts.define_modules {:fold {:attach folding}})

(tsconfigs.setup {:ensure_installed :all
                  :ignore_install [:phpdoc]

                  :highlight {:enable true
                              :addtional_vim_regex_highlighting true}

                  :rainbow {:enable true}

                  :indent {:enable true}

                  :autotag {:enable true}
                  
                  :fold {:enable true
                         :disable [:rst :make]}
                  
                  :context_commentstring {:enable true}})

(def- parser_config (parsers.get_parser_configs))
(set parser_config.tsx.filetype_to_parsername [:javascript :typescript.tsx])
