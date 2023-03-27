(fn config [_ opts]
  (local telescope (require :telescope))
  (local {: get_cursor} (require :telescope.themes))
  (set opts.extensions.ui-select (get_cursor {}))
  (telescope.setup opts)
  (telescope.load_extension :fzf)
  (telescope.load_extension :ui-select)
  (telescope.load_extension :notify))

(local dependencies
       [;; It sets vim.ui.select to telescope. 
        ;; That means for example that neovim core stuff can fill the telescope picker
        :nvim-telescope/telescope-ui-select.nvim
        ;; FZF sorter for telescope written in c
        {1 :nvim-telescope/telescope-fzf-native.nvim :build :make}])

(fn run [picker]
  #((. (require :telescope.builtin) picker)))

(fn make-fd-command []
  [:fd :--type :f :--strip-cwd-prefix :--hidden :--follow])

(fn get-root-dir [client]
  (when client
    client.config.root_dir))

(fn find-project-files []
  (local builtin (require :telescope.builtin))
  (local client (vim.lsp.get_client_by_id 1))
  (local root-dir (get-root-dir client))
  (local cwd (vim.fn.getcwd))
  (local find-file-opts {: cwd})
  (when root-dir
    (set find-file-opts.cwd root-dir))
  (when (= (vim.fn.executable :fd) 1)
    (set find-file-opts.find_command (make-fd-command)))
  (builtin.find_files find-file-opts))

(fn get-telescope-keymaps []
  [{1 :ff 2 #(find-project-files) :desc "Find files in current project folder"}
   {1 :fb 2 (run :buffers) :desc "Telescope buffers"}
   {1 :fg 2 (run :live_grep) :desc "Telescope live grep"}
   {1 :fm 2 (run :keymaps) :desc "Telescope keymaps"}
   {1 :fd
    2 (run :lsp_document_symbols)
    :desc "Telescope list lsp document symbols"}
   {1 :fr 2 (run :lsp_references) :desc "Telescope list lsp references"}
   {1 :fn 2 ":Telescope notify<cr>" :desc "Viewing Notify history"}])

(local file-ignore-patterns [:node_modules
                             :.git/
                             :.cache
                             :vendor/
                             :.mypy_cache/.*
                             :__pycache__/*
                             :venv/
                             "%.a"
                             "%.o"
                             "%.out"
                             "%.pdf"
                             "%.class"
                             "%.mkv"
                             "%.mp4"
                             "%.zip"
                             "%.png"
                             "%.jpg"])

(local vimgrep-arguments [:rg
                          :--no-heading
                          :--with-filename
                          :--line-number
                          :--column
                          :--smart-case
                          :--hidden
                          :--follow
                          :--trim])

(local opts {:defaults {:file_ignore_patterns file-ignore-patterns
                        :vimgrep_arguments vimgrep-arguments}
             :pickers {:live_grep {:theme :dropdown}}
             :extensions {}})

;; Find Filter Preview Pick. All lua all the time.
{1 :nvim-telescope/telescope.nvim
 : dependencies
 : opts
 : config
 :keys get-telescope-keymaps}

