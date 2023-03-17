(fn config []
  (local telescope (require :telescope))
  (local defaults {})
  (local pickers {})
  (local extensions {})
  (set defaults.vimgrep_arguments [:rg
                                   :--no-heading
                                   :--with-filename
                                   :--line-number
                                   :--column
                                   :--smart-case
                                   :--hidden
                                   :--follow
                                   :--trim])
  (set defaults.file_ignore_patterns
       [:node_modules
        :.git/
        :vendor/*
        :.mypy_cache/.*
        :__pycache__/*
        :*.png
        :venv/
        :*.jpg])
  (set pickers.live_grep {:theme :dropdown})
  (set extensions.ui-select ((. (require :telescope.themes) :get_cursor) {}))
  (local settings {: pickers : defaults : extensions})
  (telescope.setup settings)
  (telescope.load_extension :ui-select)
  (telescope.load_extension :notify))

(local dependencies
       [;; It sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the telescope picker
        :nvim-telescope/telescope-ui-select.nvim])

(fn telescope-builtin [name]
  (fn []
    (local builtin (require :telescope.builtin))
    ((. builtin name))))

(fn find-files-command []
  [:fd :--type :f :--strip-cwd-prefix :--hidden :--follow])

(fn find-project-files []
  (local find-files-opts {:hidden true :follow true})
  (local builtin (require :telescope.builtin))
  (var cwd (os.getenv :PWD))
  (local client (vim.lsp.get_client_by_id 1))
  (when client
    (set cwd client.config.root_dir))
  (when (= (vim.fn.executable :fd) 1)
    (set find-files-opts.find_command (find-files-command)))
  (set find-files-opts.cwd cwd)
  (builtin.find_files find-files-opts))

(fn get-telescope-keymaps []
  [{1 :ff 2 #(find-project-files) :desc "Find files in current project folder"}
   {1 :fb 2 (telescope-builtin :buffers) :desc "Telescope buffers"}
   {1 :fg 2 (telescope-builtin :live_grep) :desc "Telescope live grep"}
   {1 :fm 2 (telescope-builtin :keymaps) :desc "Telescope keymaps"}
   {1 :fd
    2 (telescope-builtin :lsp_document_symbols)
    :desc "Telescope list lsp document symbols"}
   {1 :fr
    2 (telescope-builtin :lsp_references)
    :desc "Telescope list lsp references"}
   {1 :fn 2 ":Telescope notify<cr>" :desc "Viewing Notify history"}])

;; Find Filter Preview Pick. All lua all the time.
{1 :nvim-telescope/telescope.nvim
 : config
 : dependencies
 :keys get-telescope-keymaps}

