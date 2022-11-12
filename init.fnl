(local (has_impatient? impatient) (pcall require :impatient))
(if has_impatient?
    (impatient.enable_profile))

; Basic options for neovim
(require :options)
; keymaps
(require :keymaps)
; The plugins that I use
(require :plugins)

nil
