(fn tokyonight-config [_ opts]
  (local tokyonight (require :tokyonight))
  (tokyonight.setup opts)
  (vim.cmd "colorscheme tokyonight"))

[{;; A clean dark Neovim theme written in Lua with support for lsp treesitter and lots of plugins
  1 :folke/tokyonight.nvim
  :lazy true
  :opts {:style :moon
         :tokyonight_transparent_sidebar true
         :transparent true
         :styles {:functions {:italic true}
                  :comments {:italic true}
                  :keywords {:italic true}
                  :sidebars :transparent
                  :float :transparent}}
  :config tokyonight-config}]

