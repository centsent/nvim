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

(local opts {:ensure_installed :all
             :highlight {:enable true :additional_vim_regex_highlighting false}
             :rainbow {:enable true}
             :indent {:enable true}
             :autotag {:enable true}
             :context_commentstring {:enable true}
             : textobjects})

(fn config [_ settings]
  (local ts (require :nvim-treesitter.configs))
  (ts.setup settings))

(local dependencies
       [;; Use treesitter to autoclose and autorename html tag
        :windwp/nvim-ts-autotag
        ;; Rainbow parentheses for neovim using tree-sitter
        :p00f/nvim-ts-rainbow
        ;; Neovim treesitter plugin for setting the commentstring based on the cursor location in a file
        :JoosepAlviste/nvim-ts-context-commentstring
        ;; Show code context
        :nvim-treesitter/nvim-treesitter-context
        ;; Syntax aware text-objects select move swap and peek support.
        :nvim-treesitter/nvim-treesitter-textobjects])

;; Nvim Treesitter configurations and abstraction layer
{1 :nvim-treesitter/nvim-treesitter
 :build ":TSUpdate"
 : opts
 : config
 : dependencies
 :event [:BufReadPost :BufNewFile]}

