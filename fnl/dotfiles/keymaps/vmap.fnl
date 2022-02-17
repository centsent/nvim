(module dotfiles.keymaps.vmap
  {autoload {util dotfiles.util}})

(def- vmap util.vmap)

;;; Visual Mode Keymaps

; Copy to clipboard
(vmap "<leader>y" "\"+y")
; Paste from clipboard
(vmap "<leader>p" "\"+p")
; Cut to clipboard
(vmap "<leader>x" "\"+d")
; Go to home and end using capitalized directions
(vmap "H" "^")
(vmap "L" "$")
