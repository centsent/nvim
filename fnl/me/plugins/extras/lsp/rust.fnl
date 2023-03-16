(fn setup-rust-analyzer [_ opts]
  (local rust-tools (require :rust-tools))
  (rust-tools.setup {:server opts}))

{1 :neovim/nvim-lspconfig
 :dependencies [;; A plugin to improve your rust experience in neovim.
                :simrat39/rust-tools.nvim]
 :opts {:rust_analyzer {} :setup {:rust_analyzer setup-rust-analyzer}}}

