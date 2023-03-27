(import-macros {: each!} :macros)

(fn get-current-buf-name []
  "Get the current buffer's name"
  (vim.fn.shellescape (vim.api.nvim_buf_get_name 0)))

(fn prettier-config []
  "Configure the prettier formatter for various file types"
  {:exe :prettier
   :args [:--stdin-filepath (get-current-buf-name) :--tab-width 2]
   :stdin true})

(fn lua-config []
  "Configure the stylua formatter for Lua files"
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
  "Configure the prettier formatter for Vue files"
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
  "Configure the google-java-format formatter for Java files"
  {:exe :java
   :name :google-java-format
   :stdin true
   :args [:-jar
          (.. (os.getenv :HOME) :/.local/jars/google-java-format.jar)
          (get-current-buf-name)]})

(fn php-config []
  "Configure the phpcbf formatter for PHP files"
  {:exe :phpcbf
   :args [:--standard=PSR12 (get-current-buf-name)]
   :stdin true
   :ignore_exitcode true})

(fn fennel-config []
  "Configure the fnlfmt formatter for Fennel files"
  {:exe :fnlfmt :stdin true :args [(get-current-buf-name)]})

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

(fn get-formatters []
  (local formatters
         {:lua [lua-config]
          :vue [vue-config]
          :php [php-config]
          :java [java-config]
          :fennel [fennel-config]
          :fish [(. (require :formatter.filetypes.fish) :fishindent)]
          :python [(. (require :formatter.filetypes.python) :black)]
          :ruby [(. (require :formatter.filetypes.ruby) :rubocop)]
          :rust [(. (require :formatter.filetypes.rust) :rustfmt)]})
  (each! common-filetypes
         (fn [_ filetype]
           (tset formatters filetype prettier-config)))
  formatters)

(fn config [_ opts]
  "Setup the formatter configuration for various file types and initializes the formatter"
  (set opts.filetype (get-formatters))
  (local formatter (require :formatter))
  (formatter.setup opts))

;; Opt-in formatters
{1 :mhartington/formatter.nvim
 :opts {}
 : config
 :event [:BufReadPost :BufNewFile :BufWritePost]}

