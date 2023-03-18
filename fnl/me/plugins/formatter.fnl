(fn config []
  ;; Setup the formatter configuration for various file types and initializes the formatter.
  (local formatter (require :formatter))

  (fn get-current-buf-name []
    ;; Get the current buffer's name
    (vim.fn.shellescape (vim.api.nvim_buf_get_name 0)))

  (fn prettier-config []
    ;; Configure the prettier formatter for various file types
    {:exe :prettier
     :args [:--stdin-filepath (get-current-buf-name) :--tab-width 2]
     :stdin true})

  (fn lua-config []
    ;; Configure the stylua formatter for Lua files
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
    ;; Configure the prettier formatter for Vue files
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
    ;; Configure the google-java-format formatter for Java files
    {:exe :java
     :name :google-java-format
     :stdin true
     :args [:-jar
            (.. (os.getenv :HOME) :/.local/jars/google-java-format.jar)
            (get-current-buf-name)]})

  (fn php-config []
    ;; Configure the phpcbf formatter for PHP files
    {:exe :phpcbf
     :args [:--standard=PSR12 (get-current-buf-name)]
     :stdin true
     :ignore_exitcode true})

  (fn fennel-config []
    ;; Configure the fnlfmt formatter for Fennel files
    {:exe :fnlfmt :stdin true :args [(get-current-buf-name)]})

  (local {: fishindent} (require :formatter.filetypes.fish))
  (local {: rubocop} (require :formatter.filetypes.ruby))
  (local {: rustfmt} (require :formatter.filetypes.rust))
  (local {: black} (require :formatter.filetypes.python))
  (local formatter-config {:lua [lua-config]
                           :vue [vue-config]
                           :php [php-config]
                           :java [java-config]
                           :fish [fishindent]
                           :python [black]
                           :ruby [rubocop]
                           :rust [rustfmt]
                           :fennel [fennel-config]})

  (fn setup-common-filetypes []
    ;; Configure the formatter for common file types
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
      (tset formatter-config filetype [prettier-config]))) ; (fn format-on-save [] ;   (local augroup (vim.api.nvim_create_augroup :FormatAutogroup {:clear true}))
  ;   (vim.api.nvim_create_autocmd :BufWritePost ;                                {:group augroup :command :FormatWrite}))
  (setup-common-filetypes)
  (formatter.setup {:filetype formatter-config}))

;; Opt-in formatters
{1 :mhartington/formatter.nvim : config :event :BufWritePost}

