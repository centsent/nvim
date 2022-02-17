(module dotfiles.plugin.telescope
        {autoload {builtin telescope.builtin
                   keymaps dotfiles.keymaps.telescope}})

(def- find_files builtin.find_files)

(defn find_project_files []
  "Find all files in the current project."
  (var cwd (os.getenv "PWD"))
  (def- client (vim.lsp.get_client_by_id 1))

  (if client
        (set cwd client.config.root_dir))

  (def- opt {:cwd cwd
             :hidden true})

  (find_files opt))

(keymaps.mapping)
