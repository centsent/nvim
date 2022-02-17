(module keymaps
        {autoload {util dotfiles.util}})

(def- _map util._map)

; Map leader key to comma
(set vim.g.mapleader ",")

; Map <space> to / (search)
(_map "<space>" "/")

; Disable arrow keys
(_map "<left>" "<nop>")
(_map "<right>" "<nop>")
(_map "<up>" "<nop>")
(_map "<down>" "<nop>")

(util.req :keymaps.nmap)
(util.req :keymaps.imap)
(util.req :keymaps.vmap)
