(fn init-notify []
  (local util (require :me.util))
  (when (not (util.has :noice.nvim))
    (util.on-very-lazy #(set vim.notify (require :notify)))))

[;; A fancy configurable notification manager for NeoVim
 {1 :rcarriga/nvim-notify
  :opts {:timeout 3000 :max_width 80 :background_colour "#121212"}
  :init init-notify
  :keys [{1 :<leader>n
          2 #((. (require :notify) :dismiss) {:slient true :pending true})
          :desc "Delete all notifications"}]}
 ;; Indent guides for Neovim
 {1 :lukas-reineke/indent-blankline.nvim
  :opts {:show_current_context false
         :char "│"
         :filetype_exclude [:help :alpha :dashboard :neo-tree :Trouble :lazy]
         :show_trailing_blankline_indent false}
  :event [:BufReadPost :BufNewFile]}
 ;; Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
 {1 :folke/noice.nvim
  :event :VeryLazy
  :opts {:lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                          :vim.lsp.util.stylize_markdown true}
               :signature {:enabled false}}
         :presets {:command_palette true :long_message_to_split true}}}
 ;; A snazzy bufferline for Neovim
 {1 :akinsho/bufferline.nvim
  :event :VeryLazy
  :opts {:options {:mode :tabs
                   :show_buffer_close_icons false
                   :show_close_icon false
                   :indicator {:style :underline}}}}
 ;; A pretty list for showing diagnostics references telescope results quickfix and location lists 
 ;; to help you solve all the trouble your code is causing.
 {1 :folke/trouble.nvim
  :opts {:position :right :use_diagnostic_signs true}
  :keys [{1 :gt
          2 ":TroubleToggle<cr>"
          :desc "Open trouble list (Trouble.nvim)"}]}
 ;; lua `fork` of vim-web-devicons for neovim
 {1 :kyazdani42/nvim-web-devicons :lazy true}
 ;; UI Component Library for Neovim
 {1 :MunifTanjim/nui.nvim :lazy true}
 ;; Git integration for buffers
 {1 :lewis6991/gitsigns.nvim
  :event [:BufNewFile :BufReadPost]
  :opts {:current_line_blame true}}
 ;; Extensible Neovim Scrollbar
 {1 :petertriho/nvim-scrollbar
  :opts {:excluded_filetypes [:prompt :TelescopePrompt :noice :notify]}
  :event :BufReadPost}]

