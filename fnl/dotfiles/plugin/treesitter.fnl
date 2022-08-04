(module dotfiles.plugin.treesitter
  {autoload {tsconfigs nvim-treesitter.configs}})

(tsconfigs.setup {:ensure_installed :all
                  :ignore_install [:phpdoc]

                  :highlight {:enable true
                              :addtional_vim_regex_highlighting true}

                  :rainbow {:enable true}

                  :indent {:enable true}

                  :autotag ["html" "javascript" "javascriptreact" "typescriptreact" "svelte" "vue"]})
