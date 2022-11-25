(let [(has-formatter? formatter) (pcall require :formatter)]
  (when has-formatter?
    (fn get-current-buf-name []
      (vim.fn.shellescape (vim.api.nvim_buf_get_name 0)))

    (fn prettier-config []
      {:exe :prettier
       :args [:--stdin-filepath (get-current-buf-name) :--tab-width 2]
       :stdin true})

    (fn lua-config []
      {:exe :stylua
       :args [:--indent-width
              2
              :--indent-type
              :Spaces
              :--line-endings
              :Unix
              :--quote-style
              :AutoPreferDouble]})

    (fn vue-config []
      {:exe :prettier
       :stdin true
       :args [:--stdin-filepath
              (get-current-buf-name)
              :--doule-quote
              :--tab-width
              2
              :--parser
              :vue]})

    (fn java-config []
      {:exe :java
       :name :google-java-format
       :stdin true
       :args [:-jar
              (.. (os.getenv :HOME) :/.local/jars/google-java-format.jar)
              (get-current-buf-name)]})

    (fn php-config []
      "Install phpcbf via composer:
       $ composer global require squizlabs/php_codesniffer
       and make sure global vendor binaries directory is in $PATH
       "
      {:exe :phpcbf
       :args [:--standard=PSR12 (get-current-buf-name)]
       :stdin true
       :ignore_exitcode true})

    (fn fennel-config []
      {:exe :fnlfmt :stdin true :args [(get-current-buf-name)]})

    (local {: fishindent} (require :formatter.filetypes.fish))
    (local {: rubocop} (require :formatter.filetypes.ruby))
    (local {: rustfmt} (require :formatter.filetypes.rust))
    (local formatter-config
           {:lua [lua-config]
            :vue [vue-config]
            :php [php-config]
            :java [java-config]
            :fish [fishindent]
            :ruby [rubocop]
            :rust [rustfmt]
            :fennel [fennel-config]})

    (fn setup-common-filetypes []
      (local common-filetypes [:css
                               :scss
                               :graphql
                               :html
                               :javascript
                               :javascriptreact
                               :typescript
                               :typescriptreact
                               :markdown
                               :markdown.mdx
                               :json
                               :yaml
                               :xml
                               :svg
                               :svelte])
      (each [_ filetype (ipairs common-filetypes)]
        (tset formatter-config filetype [prettier-config])))

    (fn format-on-save []
      (local augroup
             (vim.api.nvim_create_augroup :FormatAutogroup {:clear true}))
      (vim.api.nvim_create_autocmd :BufWritePost
                                   {:group augroup :command :FormatWrite}))

    (setup-common-filetypes)
    (formatter.setup {:filetype formatter-config})
    (format-on-save)))

