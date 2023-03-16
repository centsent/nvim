(fn setup-tsserver [_ opts]
  (local typescript (require :typescript))
  (typescript.setup {:server opts}))

{1 :neovim/nvim-lspconfig
 :dependencies [;; A Lua plugin written in TypeScript to write TypeScript (Lua optional).
                :jose-elias-alvarez/typescript.nvim]
 :opts {:tsserver {} :setup {:tsserver setup-tsserver}}}

