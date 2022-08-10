(module dotfiles.plugin.treesitter
  {autoload {tsconfigs nvim-treesitter.configs
             parsers nvim-treesitter.parsers}})

(tsconfigs.setup {:ensure_installed :all
                  :ignore_install [:phpdoc]
                  :highlight {:enable true
                              :addtional_vim_regex_highlighting true}
                  :rainbow {:enable true}
                  :indent {:enable true}
                  :autotag {:enable true}
                  :context_commentstring {:enable true}})

(def- parser_config (parsers.get_parser_configs))
(set parser_config.tsx.filetype_to_parsername [:javascript :typescript.tsx])
