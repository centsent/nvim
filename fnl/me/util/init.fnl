(import-macros {: not-nil! : tappend!} :macros)

(local M {})

(fn M.has [plugin]
  (local lazy (require :lazy.core.config))
  (not-nil! (. lazy.plugins plugin)))

(fn M.on-very-lazy [fun]
  (vim.api.nvim_create_autocmd :User {:pattern :VeryLazy :callback #(fun)}))

(fn M.load [mod]
  (local util (require :lazy.core.util))

  (fn on_error [msg]
    (local cache (require :lazy.core.cache))
    (local modpath (cache.find mod))
    (when modpath
      (util.error msg)))

  (util.try #(require mod) {:msg (.. "Failed loading " mod) : on_error}))

(fn M.on-attach [on-attach]
  (vim.api.nvim_create_autocmd :LspAttach
                               {:callback (fn [args]
                                            (local buffer args.buf)
                                            (local client
                                                   (vim.lsp.get_client_by_id args.data.client_id))
                                            (on-attach client buffer))}))

(fn M.get-formatter []
  (let [(ok? formatter-config) (pcall require :formatter.config)]
    (when ok?
      (local formatters formatter-config.values.filetype)
      (local ft vim.bo.filetype)
      (. formatters ft))))

(fn M.get-formatter-name []
  (local formatter (M.get-formatter))
  (if formatter
      (do
        (local names {})
        (each [_ fmt-fn (ipairs formatter)]
          (local formatter (fmt-fn))
          (when formatter
            (local name (or formatter.name formatter.exe))
            (tappend! names name)))
        (table.concat names ", "))
      ""))

(fn M.get-linter []
  (let [(has-lint? lint) (pcall require :lint)]
    (if has-lint?
        (. lint.linters_by_ft vim.bo.filetype)
        nil)))

(fn M.get-linter-name []
  (local linter (M.get-linter))
  (if linter
      (table.concat linter ", ") ""))

(fn M.is-loaded [plugin]
  (not-nil! (. (require :lazy.core.config) :plugins plugin "_" :loaded)))

M

