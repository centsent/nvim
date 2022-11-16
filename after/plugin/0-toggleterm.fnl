(let [(has_toggleterm? toggleterm) (pcall require :toggleterm)]
  (when has_toggleterm?
    (local Terminal (. (require :toggleterm.terminal) :Terminal))
    (toggleterm.setup {:open_mapping :<leader>tt :direction :float})

    (fn make_lazygit_terminal []
      (Terminal:new {:cmd :lazygit
                     :direction :float
                     :float_opts {:border :curved}}))

    (fn setup_lazygit_terminal []
      (local lazygit_terminal (make_lazygit_terminal))
      (vim.keymap.set :n :<leader>tg
                      (lambda []
                        (lazygit_terminal:toggle))))

    (if (= (vim.fn.executable :lazygit) 1)
        (setup_lazygit_terminal))))

