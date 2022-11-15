(let [(has_telescope? telescope) (pcall require :telescope)]
  (when has_telescope?
    (local builtin (require :telescope.builtin))
    (fn with [func]
      (lambda []
        (func)))

    (local find_files_opts {:hidden true :follow true})
    (local settings {
      :defaults { 
        :vimgrep_arguments [
          "rg"
          "--no-heading"
          "--with-filename"
          "--line-number"
          "--column"
          "--smart-case"
          "--hidden"
          "--follow"
        ]
      :file_ignore_patterns [ 
        "node_modules"
        ".git/*"
        "vendor/*"
        ".mypy_cache/.*"
        "__pycache__/*"
        "*.png"
        "*.jpg"
      ]
      }
      :extensions {
        :ui-select ((. (require :telescope.themes) :get_cursor) {})
      }
    })

    (fn setup [config]
      (telescope.setup config)
      (telescope.load_extension "ui-select"))

    (fn find_files_command []
      ["fd"
       "--type"
       "f"
       "--strip-cwd-prefix"
       "--color"
       "never"
       ])

    (fn find_project_files []
      (var cwd (os.getenv "PWD"))
      (local client (vim.lsp.get_client_by_id 1))
      (when client
        (set cwd client.config.root_dir))

      (when (= (vim.fn.executable "fd") 1)
        (set find_files_opts.find_command (find_files_command)))

      (set find_files_opts.cwd cwd)
      (builtin.find_files find_files_opts))

    (local telescope_keymaps {
      :normal_mode {
        :ff (with find_project_files)
        :fb (with builtin.buffers)
        :fg (with builtin.live_grep)
        :fm (with builtin.keymaps)
        :fd (with builtin.lsp_document_symbols)
        :fr (with builtin.lsp_references)
        :fn ":Telescope notify<cr>"
      }
    })

    (fn set_keymaps [keymaps]
      ((. (require :keymaps) :load_keymaps) keymaps))

    (setup settings)
    (set_keymaps telescope_keymaps)))
