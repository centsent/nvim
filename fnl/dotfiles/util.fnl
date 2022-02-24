(module dotfiles.util)

(defn req [name]
  "A shortcut to building a require string for your plugin
  configuration. Intended for use with packer's config or setup
  configuration options. Will prefix the name with `dotfiles.`
  before requiring."
  (pcall require (.. "dotfiles." name)))

(defn merge_tables [...]
  "Merge multiple tables into one new table."
  (local result {})

  (let [tables [...]]
    (each [_ tbl (ipairs tables)]
      (each [k v (pairs tbl)]
        (tset result k v))))

  result)

(defn map [mode from to opt]
  "Creates a mode-specific keymap."
  (vim.api.nvim_set_keymap mode from to (or opt {})))

; Set keymap in Normal mode
(def nmap (partial map "n"))
; Set keymap in Visual mode
(def vmap (partial map "v"))
; Set keymap in Insert mode
(def imap (partial map "i"))
; Creates a key map that works in normal, visual, select and operator pending modes.
(def _map (partial map ""))
