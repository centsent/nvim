(module dotfiles.plugin.treesitter
  {autoload {tsconfigs nvim-treesitter.configs}})

(tsconfigs.setup {:ensure_installed ["c" 
                                     "cpp" 
                                     "c_sharp" 
                                     "css" 
                                     "cmake"
                                     "html"
                                     "lua" 
                                     "fennel" 
                                     "graphql"
                                     "javascript" 
                                     "json"
                                     "rust" 
                                     "typescript"
                                     "tsx"
                                     "vim"]

                  :highlight {:enable true
                              :addtional_vim_regex_highlighting true}})
