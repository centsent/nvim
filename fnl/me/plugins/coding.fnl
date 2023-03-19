[;; A native neovim extension for Codeium
 {1 :jcdickinson/codeium.nvim
  :build ":Codeium Auth"
  :event [:InsertEnter]
  :dependencies [:nvim-lua/plenary.nvim :hrsh7th/nvim-cmp]
  :config true}
 ;; A tree like view for symbols in Neovim using the Language Server Protocol
 {1 :simrat39/symbols-outline.nvim
  :keys [{1 :<leader>cs 2 :<cmd>SymbolsOutline<cr> :desc "Symbols Outline"}]
  :config true}
 ;; A better annotation generator
 {1 :danymat/neogen
  :dependencies [:nvim-treesitter/nvim-treesitter]
  :keys [{1 :<leader>cc
          2 #((. (require :neogen) :generate) {})
          :desc "Neogen Comment"}]
  :opts {:snippet_engine :luasnip}}]

