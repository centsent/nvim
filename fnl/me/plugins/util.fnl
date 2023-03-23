(import-macros {: g!} :macros)

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
  :config #(g! :startuptime_tries 10)}
 ;; Single tabpage interface for easily cycling through diffs for all modified files for any git rev
 {1 :sindrets/diffview.nvim
  :cmd {:DiffviewOpen :DiffviewClose :DiffviewToggleFiles :DiffviewFocusFiles}
  :config true
  :keys [{1 :<leader>gd 2 :<cmd>DiffviewOpen<cr> :desc :DiffView}]}
 ;; All the lua functions I don't want to write twice.
 {1 :nvim-lua/plenary.nvim :lazy true}
 ;; For my personal use only
 ;; The open source plugin for productivity metrics goals leaderboards and automatic time tracking.
 {1 :wakatime/vim-wakatime :event [:CursorMoved]}]

