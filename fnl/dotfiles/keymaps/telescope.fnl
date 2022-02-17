(module dotfiles.keymaps.telescope
        {autoload {util dotfiles.util
                   telescope telescope}})

(def- nmap util.nmap)

(telescope.setup
  {:defaults
  {:vimgrep_arguments ["rg" "--color=never" "--no-heading"
                       "--with-filename" "--line-number" "--column"
                       "--smart-case" "--hidden" "--follow"
                       "-g" "!.git/"]}})

(defn mapping []
  "Telescope keymaps."

  ; List files in current project.
  (nmap "ff" ":lua require'dotfiles.plugin.telescope'.find_project_files()<cr>")
  (nmap "fg" ":Telescope live_grep<cr>")
  (nmap "fm" ":Telescope keymaps<cr>")
  (nmap "fr" ":Telescope lsp_references<cr>")
  (nmap "fd" ":Telescope lsp_document_symbols<cr>"))
