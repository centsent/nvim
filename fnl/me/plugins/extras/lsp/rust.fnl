(fn setup-rust-analyzer [_ opts]
  (local rust-tools (require :rust-tools))
  (rust-tools.setup {:server opts}))

[{1 :neovim/nvim-lspconfig
  :dependencies [;; A plugin to improve your rust experience in neovim.
                 :simrat39/rust-tools.nvim]
  :opts {:rust_analyzer {} :setup {:rust_analyzer setup-rust-analyzer}}}
 ;; A neovim plugin that helps managing crates.io dependencies
 {1 :saecki/crates.nvim
  :event ["BufRead Cargo.toml"]
  :config (fn [_ opts]
            (let [(has-cmp? cmp) (pcall require :cmp)]
              (when has-cmp?
                (cmp.setup.buffer {:sources [{:name :crates}]})))
            ((. (require :crates) :setup) opts))}]

