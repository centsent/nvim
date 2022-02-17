(module keymaps
        {autoload {util dotfiles.util}})

(def- nmap util.nmap)
(def- vmap util.vmap)
(def- imap util.imap)
(def- _map util._map)

(def- silent { :silent true })
(def- noremap-silent { :noremap true :silent true })

; Map leader key to comma
(set vim.g.mapleader ",")

; Map <space> to / (search)
(_map "<space>" "/")

; Disable arrow keys
(_map "<left>" "<nop>")
(_map "<right>" "<nop>")
(_map "<up>" "<nop>")
(_map "<down>" "<nop>")


;; Normal Mode
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
(nmap "<leader>tt" ":tabnew<cr>")
(nmap "<leader>tp" ":tabprevious<cr>")
(nmap "<leader>tn" ":tabnext<cr>")

; New horizontal split(editing current buffer)
(nmap "<space>1" "<c-w>s")
; Split window vertically(editing current buffer)
(nmap "<space>2" "<c-w>v")

; Toggle netrw
(nmap "<leader>f" ":Lex<cr>")


;; Insert Mode
; Use <c-j> for escaping
(imap "<c-j>" "<esc>")

; Directions in insert mode
(imap "<c-b>" "<c-o>h")
(imap "<c-n>" "<c-o>j")
(imap "<c-p>" "<c-o>k")
(imap "<c-f>" "<c-o>l")

; Go to home
(imap "<c-a>" "<c-o>^")
; Go to end
(imap "<c-e>" "<c-o>$")
; Scroll up
(imap "<c-u>" "<c-\\><c-o><c-u>")
; Scroll down
(imap "<c-d>" "<c-\\><c-o><c-d>")

; Quickly save and escape to normal mode
(imap "<leader>," "<esc>:w<cr>")


;; Visual Mode
; Copy to clipboard
(vmap "<leader>y" "\"+y")
; Paste from clipboard
(vmap "<leader>p" "\"+p")
; Cut to clipboard
(vmap "<leader>x" "\"+d")
; Go to home and end using capitalized directions
(vmap "H" "^")
(vmap "L" "$")
