{1 :neovim/nvim-lspconfig
 :dependencies [{;; Go development plugin for Vim
                 1 :fatih/vim-go
                 :build ":GoUpdateBinaries"}]
 :opts {:servers {:gopls {}}}}

