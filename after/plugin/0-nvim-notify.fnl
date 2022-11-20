(let [(has_notify? notify) (pcall require :notify)]
  (when has_notify?
    (local settings {:background_colour "#121212" :max_width 80})
    (notify.setup settings)
    (set vim.notify notify)
    (vim.keymap.set :n :<leader>n #(notify.dismiss))))

