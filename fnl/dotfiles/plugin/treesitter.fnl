(module dotfiles.plugin.treesitter
  {autoload {tsconfigs nvim-treesitter.configs}})

(tsconfigs.setup {:ensure_installed :all
                  :ignore_install [:phpdoc]

                  :highlight {:enable true
                              :addtional_vim_regex_highlighting true}

                  :rainbow {:enable true}

                  :indent {:enable true}

                  :autotag ["html" "javascript" "javascriptreact" "typescriptreact" "svelte" "vue"]})

; Code folding with treesitter
(vim.cmd "set foldmethod=expr")
(vim.cmd "set foldexpr=nvim_treesitter#foldexpr()")
(vim.cmd "autocmd BufReadPost,FileReadPost * normal zR")
