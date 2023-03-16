(fn config [_ opts]
  (local toggleterm (require :toggleterm))
  (local {: Terminal} (require :toggleterm.terminal))
  (toggleterm.setup opts)

  (fn make-lazygit-terminal []
    (Terminal:new {:cmd :lazygit
                   :direction :float
                   :float_opts {:border :curved}}))

  (fn setup-lazygit-terminal []
    (local lazygit-terminal (make-lazygit-terminal))
    (vim.keymap.set :n :<leader>tg
                    (fn []
                      (lazygit-terminal:toggle))))

  (if (= (vim.fn.executable :lazygit) 1)
      (setup-lazygit-terminal)))

;; A neovim lua plugin to help easily manage multiple terminal windows
{1 :akinsho/toggleterm.nvim
 :opts {:direction :float}
 :keys [{1 :<leader>tt 2 ":ToggleTerm<cr>" :desc "Toggle terminal"}]
 :event [:BufReadPost :BufNewFile]
 : config}

