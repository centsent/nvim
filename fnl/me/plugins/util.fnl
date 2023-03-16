[;; A plugin for profiling Vim and Neovim startup time
 {1 :dstein64/vim-startuptime
  :cmd :StartupTime
  :config (fn []
            (set vim.g.startuptime_tries 10))}
 ;; All the lua functions I don't want to write twice.
 [:nvim-lua/plenary.nvim]
 ;; For my personal use only
 ;; The open source plugin for productivity metrics goals leaderboards and automatic time tracking.
 {1 :wakatime/vim-wakatime :event [:CursorMoved]}]

