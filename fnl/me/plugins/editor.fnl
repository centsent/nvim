(fn open-ssr []
  ;; Open the SSR (structural search and replace) plugin
  (local ssr (require :ssr))
  (ssr.open))

[;; A file explorer tree for neovim written in lua
 {1 :nvim-tree/nvim-tree.lua
  :keys [{1 :<leader>f 2 ":NvimTreeToggle<cr>" :desc "Explorer NvimTree"}]
  :opts {:disable_netrw true}}
 ;; Smart and powerful comment plugin for neovim
 {1 :numToStr/Comment.nvim
  :config true
  :lazy true
  :event [:BufReadPost :BufNewFile]}
 ;; Treesitter based structural search and replace plugin for Neovim
 {1 :cshuaimin/ssr.nvim
  :keys [{1 :<leader>sr 2 open-ssr :desc "Replace in files (ssr.nvim)"}]}
 ;; EditorConfig plugin for Neovim
 {1 :gpanders/editorconfig.nvim :event [:BufNewFile :BufReadPost]}
 ;; A super powerful autopair plugin for Neovim that supports multiple characters
 {1 :windwp/nvim-autopairs :config true :event [:BufNewFile :BufReadPost]}
 ;; Add/change/delete surrounding delimiter pairs with ease.
 {1 :kylechui/nvim-surround :config true :event [:BufNewFile :BufReadPost]}
 ;; The fastest Neovim colorizer.
 {1 :norcalli/nvim-colorizer.lua
  :config true
  :event [:BufNewFile :BufReadPost]}
 ;; Next-generation motion plugin using incremental input processing
 {1 :ggandor/leap.nvim
  :event [:BufNewFile :BufReadPost]
  :config (fn []
            ;; Initialize and configure the Leap motion plugin for Neovim
            (local leap (require :leap))
            (leap.add_default_mappings))}]

