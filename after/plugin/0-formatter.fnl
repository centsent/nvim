(let [(has_formatter? formatter) (pcall require :formatter)]
  (when has_formatter?
    (fn get_current_buf_name []
      (vim.fn.shellescape (vim.api.nvim_buf_get_name 0)))

    (fn prettier_config []
      {
        :exe "prettier"
        :args [ 
          "--stdin-filepath"
          (get_current_buf_name)
          "--tab-width"
          2
        ]
        :stdin true
      })

    (fn lua_config []
      {
        :exe "stylua"
        :args [
          "--indent-width"
          2
          "--indent-type"
          "Spaces"
          "--line-endings"
          "Unix"
          "--quote-style"
          "AutoPreferDouble"
        ]
      })

    (fn vue_config []
      {
        :exe "prettier"
        :stdin true
        :args [ 
          "--stdin-filepath"
          (get_current_buf_name)
          "--doule-quote"
          "--tab-width"
          2
          "--parser"
          "vue"
        ]
      })

    (fn java_config []
      {
        :exe "java"
        :name "google-java-format"
        :stdin true
        :args [ 
          "-jar"
          (.. (os.getenv "HOME") "/.local/jars/google-java-format.jar")
          (get_current_buf_name)
        ]
      })

    (fn php_config []
      {
        ; Install phpcbf via composer:
        ; $ composer global require squizlabs/php_codesniffer
        ; and make sure global vendor binaries directory is in $PATH
        :exe "phpcbf"
        :args [ 
          "--standard=PSR12"
          (get_current_buf_name)
        ]
        :stdin true
        :ignore_exitcode true
      })

    (local formatter_config {
      :lua [lua_config] 
      :vue [vue_config]
      :php [php_config]
      :java [java_config]
      :fish [(. (require :formatter.filetypes.fish) :fishindent)]
      :ruby [(. (require :formatter.filetypes.ruby) :rubocop)]
    })

    (local common_filetypes [
      "css"
      "scss"
      "html"
      "javascript"
      "javascriptreact"
      "typescript"
      "typescriptreact"
      "markdown"
      "markdown.mdx"
      "json"
      "yaml"
      "xml"
      "svg"
      "svelte"
    ])

    (each [_ filetype (ipairs common_filetypes)]
      (tset formatter_config filetype [prettier_config]))

    (formatter.setup { :filetype formatter_config })
    (local augroup (vim.api.nvim_create_augroup "FormatAutogroup" { :clear true }))
    (vim.api.nvim_create_autocmd "BufWritePost" {
      :group augroup
      :command "FormatWrite"
    })))
