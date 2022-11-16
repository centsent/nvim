(let [(has_lualine? lualine) (pcall require :lualine)]
  (when has_lualine?
    (local lsp_signs (. (require :me.lsp) :signs))
    (local bold :bold)
    (local colors {:bg "#292e42"
                   :fg "#bbc2cf"
                   :lightblue "#7aa2f7"
                   :lime "#9ece6a"
                   :yellow "#ECBE7B"
                   :cyan "#008080"
                   :green "#98be65"
                   :orange "#e0af68"
                   :magenta "#c678dd"
                   :blue "#51afef"
                   :red "#ec5f67"
                   :lavender "#bb9af7"
                   :rose "#f7768e"
                   :white "#ffffff"})
    (local mode_colors {:n colors.lightblue
                        :v colors.lavender
                        :x colors.rose
                        :i colors.lime
                        :o colors.cyan
                        :R colors.rose})
    (local icons {:branch "" :added " " :modified " " :removed " "})
    (local components
           {:fileformat {1 :fileformat
                         :color {:bg colors.bg :fg colors.green :gui bold}}
            :encoding {1 :encoding
                       :color {:bg colors.bg :fg colors.green :gui bold}
                       :fmt string.upper}
            :filename {1 :filename :color {:fg colors.blue :gui bold}}
            :filetype {1 :filetype :icon_only true}
            :filesize {1 :filesize :color {:fg colors.white}}
            :progress {1 :progress
                       :color {:bg colors.bg :fg colors.fg :gui bold}}
            :location {1 :location
                       :color {:bg colors.bg :fg colors.fg :gui bold}}
            :branch {1 :branch
                     :icon icons.branch
                     :color {:bg colors.bg :fg colors.magenta :gui bold}}
            :diff {1 :diff
                   :symbols {:added icons.added
                             :modified icons.modified
                             :removed icons.removed}
                   :diff_color {:added {:fg colors.green}
                                :modified {:fg colors.orange}
                                :removed {:fg colors.red}}
                   :color {:bg colors.bg}}
            :diagnostics {1 :diagnostics
                          :sources [:nvim_diagnostic]
                          :symbols {:error lsp_signs.Error
                                    :warn lsp_signs.Warn
                                    :info lsp_signs.Info}
                          :diagnostics_color {:color_error {:fg colors.red}
                                              :color_warn {:fg colors.yellow}
                                              :color_info {:fg colors.cyan}}
                          :color {:bg colors.bg}}
            :lsp {1 (lambda []
                      (local bufnr (vim.api.nvim_get_current_buf))
                      (local clients (vim.lsp.get_active_clients {: bufnr}))
                      (if (= nil (next clients)) "No Active LSP"
                          (do
                            (local names {})
                            (each [_ client (pairs clients)]
                              (tset names (+ (length names) 1) client.name))
                            (table.concat names " "))))
                  :color {:fg colors.white :gui bold}}
            :formatter {1 (lambda []
                            ((. (require :utils) :get_formatter_name)))
                        :color {:fg colors.green}}
            :linter {1 (lambda []
                         ((. (require :utils) :get_linter_name)))
                     :color {:fg colors.cyan}}
            :gap [(lambda []
                    "%=")]
            :mode {1 :mode
                   :color (lambda []
                            (local fg_color
                                   (or (. mode_colors (vim.fn.mode))
                                       colors.rose))
                            {:fg fg_color :bg colors.bg})}
            :time {1 (lambda []
                       (string.format "%s" (os.date "%H:%M:%S")))
                   :color {:fg colors.green :bg colors.bg}}})
    (local config {:options {:component_separators "" :section_separators ""}
                   :sections {:lualine_a [components.mode]
                              :lualine_b [components.branch
                                          components.diff
                                          components.diagnostics]
                              :lualine_c [components.filetype
                                          components.filename
                                          components.filesize
                                          components.gap
                                          components.lsp
                                          components.formatter
                                          components.linter]
                              :lualine_x [components.progress]
                              :lualine_y [components.location]
                              :lualine_z [components.encoding
                                          components.fileformat
                                          components.time]}})

    (fn setup [user_config]
      (lualine.setup user_config))

    (setup config)))

