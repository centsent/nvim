(let [(has_lualine? lualine) (pcall require :lualine)]
  (when has_lualine?
    (local lsp-signs (. (require :me.lsp) :signs))
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
    (local mode-colors {:n colors.lightblue
                        :v colors.lavender
                        :x colors.rose
                        :i colors.lime
                        :o colors.cyan
                        :R colors.rose})
    (local icons {:branch "" :added " " :modified " " :removed " "})
    (local fileformat
           {1 :fileformat :color {:bg colors.bg :fg colors.green :gui bold}})
    (local encoding {1 :encoding
                     :color {:bg colors.bg :fg colors.green :gui bold}
                     :fmt string.upper})
    (local filename {1 :filename :color {:fg colors.blue :gui bold}})
    (local filetype {1 :filetype :icon_only true})
    (local filesize {1 :filesize :color {:fg colors.white}})
    (local progress
           {1 :progress :color {:bg colors.bg :fg colors.fg :gui bold}})
    (local location
           {1 :location :color {:bg colors.bg :fg colors.fg :gui bold}})
    (local branch
           {1 :branch
            :icon icons.branch
            :color {:bg colors.bg :fg colors.magenta :gui bold}})
    (local diff-symbols {:added icons.added
                         :modified icons.modified
                         :removed icons.removed})
    (local diff-color {:added {:fg colors.green}
                       :modified {:fg colors.orange}
                       :removed {:fg colors.red}})
    (local diff {1 :diff
                 :symbols diff-symbols
                 :diff_color diff-color
                 :color {:bg colors.bg}})
    (local diagnostics-symbols
           {:error lsp-signs.Error :warn lsp-signs.Warn :info lsp-signs.Info})
    (local diagnostics-color
           {:color_error {:fg colors.red}
            :color_warn {:fg colors.yellow}
            :color_info {:fg colors.cyan}})
    (local diagnostics {1 :diagnostics
                        :sources [:nvim_diagnostic]
                        :symbols diagnostics-symbols
                        :diagnostics_color diagnostics-color
                        :color {:bg colors.bg}})

    (fn set-lsp []
      (local bufnr (vim.api.nvim_get_current_buf))
      (local clients (vim.lsp.get_active_clients {: bufnr}))
      (if (= nil (next clients)) "No Active LSP"
          (do
            (local names {})
            (each [_ client (pairs clients)]
              (tset names (+ (length names) 1) client.name))
            (table.concat names " "))))

    (local lsp {1 set-lsp :color {:fg colors.white :gui bold}})
    (local formatter {1 (lambda []
                          ((. (require :utils) :get_formatter_name)))
                      :color {:fg colors.green}})
    (local linter {1 (lambda []
                       ((. (require :utils) :get_linter_name)))
                   :color {:fg colors.cyan}})
    (local gap [(lambda []
                  "%=")])

    (fn set-mode-color []
      (local fg_color (or (. mode-colors (vim.fn.mode)) colors.rose))
      {:fg fg_color :bg colors.bg})

    (local mode {1 :mode :color set-mode-color})

    (fn get-current-time []
      (string.format "%s" (os.date "%H:%M:%S")))

    (local time {1 get-current-time :color {:fg colors.green :bg colors.bg}})
    (local components {: encoding
                       : filename
                       : filetype
                       : filesize
                       : progress
                       : location
                       : branch
                       : diff
                       : diagnostics
                       : lsp
                       : formatter
                       : linter
                       : gap
                       : mode
                       : time})
    (local sections {:lualine_a [components.mode]
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
                                 components.time]})
    (local config {:options {:component_separators "" :section_separators ""}
                   : sections})

    (fn setup [user_config]
      (lualine.setup user_config))

    (setup config)))

