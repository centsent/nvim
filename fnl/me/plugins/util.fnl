(fn make-lazygit-terminal []
  ;; Create a new lazygit terminal instance
  (local {: Terminal} (require :toggleterm.terminal))
  (Terminal:new {:cmd :lazygit :direction :float :float_opts {:border :curved}}))

(fn toggle-lazygit-terminal []
  ;; Toggle the lazygit terminal on and off
  (local lazygit-terminal (make-lazygit-terminal))
  (lazygit-terminal:toggle))

[;;A neovim lua plugin to help easily manage multiple terminal windows
 {1 :akinsho/toggleterm.nvim
  :opts {:direction :float}
  :keys [{1 :<leader>tt 2 ":ToggleTerm<cr>" :desc "Toggle terminal"}
         {1 :<leader>tg
          2 #(toggle-lazygit-terminal)
          :desc "Toggle lazygit terminal"}]}
 ;; A plugin for profiling Vim and Neovim startup time
 {1 :dstein64/vim-startuptime
  :cmd :StartupTime
  :config (fn []
            (set vim.g.startuptime_tries 10))}
 ;; All the lua functions I don't want to write twice.
 [:nvim-lua/plenary.nvim]
 ;; For my personal use only
 ;; The open source plugin for productivity metrics goals leaderboards and automatic time tracking.
 {1 :wakatime/vim-wakatime :event [:CursorMoved]}]

