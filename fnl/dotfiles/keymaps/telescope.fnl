(module dotfiles.keymaps.telescope
  {autoload {util dotfiles.util
             telescope telescope}})

(def- nmap util.nmap)

(telescope.setup
  {:defaults {:vimgrep_arguments ["rg" 
                                  "--color=never" 
                                  "--no-heading"
                                  "--with-filename" 
                                  "--line-number" 
                                  "--column"
                                  "--smart-case" 
                                  "--hidden" 
                                  "--follow"
                                  "-g"
                                  "!.git/"]
              :file_ignore_patterns ["node_modules" ".git"]}})

(defn mapping []
  "Telescope keymaps."

  ; List files in current project.
  (nmap "ff" ":lua require'dotfiles.plugin.telescope'.find_project_files()<cr>")
  (nmap "fb" ":Telescope buffers<cr>")
  (nmap "fg" ":Telescope live_grep<cr>")
  (nmap "fm" ":Telescope keymaps<cr>")
  (nmap "fa" ":Telescope lsp_code_actions<cr>")
  (nmap "fr" ":Telescope lsp_references<cr>")
  (nmap "fd" ":Telescope lsp_document_symbols<cr>")
  (nmap "fp" ":lua require'telescope'.extensions.project.project{}<cr>"))
