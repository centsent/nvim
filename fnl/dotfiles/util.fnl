(module dotfiles.util)

(defn map [mode from to opt]
  (vim.api.nvim_set_keymap mode from to (or opt {})))

(def nmap (partial map "n"))
(def vmap (partial map "v"))
(def imap (partial map "i"))
(def _map (partial map ""))
