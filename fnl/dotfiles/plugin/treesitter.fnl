(module dotfiles.plugin.treesitter
  {autoload {tsconfigs nvim-treesitter.configs
             parsers nvim-treesitter.parsers}})

(tsconfigs.setup {:ensure_installed :all
                  :ignore_install [:phpdoc]

                  :highlight {:enable true
                              :addtional_vim_regex_highlighting true}

                  :rainbow {:enable true}

                  :indent {:enable true}

                  :autotag {:enable true}})

; Code folding with treesitter
(vim.cmd "set foldmethod=expr")
(vim.cmd "set foldexpr=nvim_treesitter#foldexpr()")
(vim.cmd "autocmd BufReadPost,FileReadPost * normal zR")

(def- parser_config (parsers.get_parser_configs))
(set parser_config.tsx.filetype_to_parsername [:javascript :typescript.tsx])
