(module dotfiles.keymaps.imap
  {autoload {util dotfiles.util}})

(def- imap util.imap)

;;; Insert Mode Keymaps

; Use <c-j> for escaping and quickly save
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
