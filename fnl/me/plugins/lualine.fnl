(import-macros {: tappend!} :macros)
(local config (require :me.config))
(local lsp-signs config.icons.diagnostics)
(local git-icons config.icons.git)
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

;; File format component
(local fileformat
       {1 :fileformat :color {:bg colors.bg :fg colors.green :gui bold}})

;; File encoding component
(local encoding {1 :encoding
                 :color {:bg colors.bg :fg colors.green :gui bold}
                 :fmt string.upper})

;; File name component
(local filename {1 :filename :color {:fg colors.blue :gui bold}})
;; File type component
(local filetype {1 :filetype :icon_only true})
;; File size component
(local filesize {1 :filesize :color {:fg colors.white}})
;; Cursor progress component
(local progress {1 :progress :color {:bg colors.bg :fg colors.fg :gui bold}})
;; Cursor location component
(local location {1 :location :color {:bg colors.bg :fg colors.fg :gui bold}})
;; Git branch component
(local branch
       {1 :branch
        :icon git-icons.branch
        :color {:bg colors.bg :fg colors.magenta :gui bold}})

(local diff-symbols {:added git-icons.added
                     :modified git-icons.modified
                     :removed git-icons.removed})

(local diff-color {:added {:fg colors.green}
                   :modified {:fg colors.orange}
                   :removed {:fg colors.red}})

;; Git diff component
(local diff {1 :diff
             :symbols diff-symbols
             :diff_color diff-color
             :color {:bg colors.bg}})

(local diagnostics-symbols {:error lsp-signs.Error
                            :warn lsp-signs.Warn
                            :info lsp-signs.Info})

(local diagnostics-color
       {:color_error {:fg colors.red}
        :color_warn {:fg colors.yellow}
        :color_info {:fg colors.cyan}})

;; LSP diagnostics component
(local diagnostics {1 :diagnostics
                    :sources [:nvim_diagnostic]
                    :symbols diagnostics-symbols
                    :diagnostics_color diagnostics-color
                    :color {:bg colors.bg}})

(fn get-lsp []
  (local bufnr (vim.api.nvim_get_current_buf))
  (local clients (vim.lsp.get_active_clients {: bufnr}))

  (fn get-lsp-client-name []
    (local names {})
    (each [_ client (pairs clients)]
      (when (not (vim.tbl_contains names client.name))
        (tappend! names client.name)))
    (table.concat names ", "))

  (if (next clients)
      (get-lsp-client-name)
      ;; No active lsp client
      "No Active LSP"))

;; LSP client name component
(local lsp {1 get-lsp :color {:fg colors.white :gui bold}})
;; Buffer formatter name component
(local formatter
       {1 #((. (require :me.util) :get-formatter-name))
        :color {:fg colors.green}
        :cond (fn []
                ((. (require :me.util) :is-loaded) :formatter.nvim))})

;; Buffer linter name component
(local linter
       {1 #((. (require :me.util) :get-linter-name))
        :color {:fg colors.cyan}
        :cond (fn []
                ((. (require :me.util) :is-loaded) :nvim-lint))})

;; A gap between components
(local gap ["%="])

(fn get-mode-color []
  (local fg (or (. mode-colors (vim.fn.mode)) colors.rose))
  {: fg :bg colors.bg})

;; Vim mode component
(local mode {1 :mode :color get-mode-color})

(fn get-current-time []
  (string.format "%s" (os.date "%H:%M:%S")))

;; Current time component
(local time {1 get-current-time :color {:fg colors.green :bg colors.bg}})

(local components {: encoding
                   : fileformat
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

;; A blazing fast and easy to configure neovim statusline plugin written in pure lua.
{1 :nvim-lualine/lualine.nvim
 :opts {:options {:component_separators "" :section_separators ""} : sections}
 :event :VeryLazy}

