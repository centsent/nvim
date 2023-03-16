(local M {})

(fn set-colorscheme []
  (let [(has-tyokonight? tokyonight) (pcall require :tokyonight)]
    (tokyonight.load)))

(fn load-configs []
  (local util (require :me.util))
  (local config-prefix :me.config.)
  (local mods [:options :keymaps])
  (each [_ mod (ipairs mods)]
    (util.load (.. config-prefix mod))))

(fn M.setup [opts]
  (local util (require :me.util))
  (util.on-very-lazy (fn [params]
                       (set-colorscheme)
                       (load-configs))))

M

