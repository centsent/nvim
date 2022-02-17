(module dotfiles.keymaps.nmap
  {autoload {util dotfiles.util}})

(def- nmap util.nmap)
(def- noremap-silent {:noremap true 
                      :silent true })

;;; Normal Mode Keymaps

; ex mode commands made easy
(nmap ";" ":")

; Don't highlight search result
(nmap "<leader>/" ":nohlsearch<cr>" noremap-silent)

; Fast saving
(nmap "<leader>w" ":w!<cr>")

; Quickly close the current window/buffer
(nmap "<leader>q" ":q<cr>")

; Remap U to <c-r> for easier undo
(nmap "U" "<c-r>")

; Go to home and end using capitalized directions
(nmap "H" "^")
(nmap "L" "$")

; Treat long lines as break lines (useful when moving around in them)
(nmap "k" "gk" noremap-silent)
(nmap "gk" "k" noremap-silent)
(nmap "j" "gj" noremap-silent)
(nmap "gj" "j" noremap-silent)

; Move a line of text up and down
(nmap "<c-j>" "mz:m+<cr>`z")
(nmap "<c-k>" "mz:m-2<cr>`z")

; Use tab for circular windows navigation
(nmap "<tab>" "<c-w>w")

; Mappings for managing tabs
(nmap "tt" ":tabnew<cr>")
(nmap "tp" ":tabprevious<cr>")
(nmap "tn" ":tabnext<cr>")

; New horizontal split(editing current buffer)
(nmap "<space>1" "<c-w>s")
; Split window vertically(editing current buffer)
(nmap "<space>2" "<c-w>v")

; Toggle netrw
(nmap "<leader>f" ":Lex<cr>")


