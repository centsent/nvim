(local M {})

(set M.icons {:diagnostics {:Error " "
                            :Warn " "
                            :Hint " "
                            :Info " "}
              :git {:added " "
                    :modified " "
                    :removed " "
                    :branch ""}
              :kinds {:Array " "
                      :Boolean " "
                      :Class " "
                      :Color " "
                      :Constant " "
                      :Constructor " "
                      :Copilot " "
                      :Enum " "
                      :EnumMember " "
                      :Event " "
                      :Field " "
                      :File " "
                      :Folder " "
                      :Function " "
                      :Interface " "
                      :Key " "
                      :Keyword " "
                      :Method " "
                      :Module " "
                      :Namespace " "
                      :Null "ﳠ "
                      :Number " "
                      :Object " "
                      :Operator " "
                      :Package " "
                      :Property " "
                      :Reference " "
                      :Snippet " "
                      :String " "
                      :Struct " "
                      :Text " "
                      :TypeParameter " "
                      :Unit " "
                      :Value " "
                      :Variable " "}})

(fn set-colorscheme []
  (let [(has-tyokonight? tokyonight) (pcall require :tokyonight)]
    (when has-tyokonight?
      (tokyonight.load))))

(fn load-configs []
  (local util (require :me.util))
  (local config-prefix :me.config.)
  (local mods [:options :keymaps :autocmds])
  (each [_ mod (ipairs mods)]
    (util.load (.. config-prefix mod))))

(fn M.setup []
  (local util (require :me.util))
  (util.on-very-lazy (fn []
                       (set-colorscheme)
                       (load-configs))))

M

