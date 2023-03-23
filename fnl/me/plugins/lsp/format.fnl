(import-macros {: not-nil!} :macros)
(local M {})

(set M.autoformat true)

(fn M.toggle []
  ;; Toggle autoformatting on save
  (set M.autoformat (not M.autoformat))
  (local lazy-util (require :lazy.core.util))
  (if M.autoformat
      (lazy-util.info "Enabled format on save" {:title :LspFormat})
      (lazy-util.warn "Disabled format on save" {:title :LspFormat})))

(fn M.format []
  ;; Formats the current buffer if autoformat is enabled
  ;; Checks for a formatter and runs the appropriate format command
  (when M.autoformat
    (local {: get-formatter} (require :me.util))
    (local formatter (get-formatter))
    (if (not-nil! formatter)
        (vim.cmd :FormatWrite)
        (vim.lsp.buf.format))))

(fn M.on-attach [_ buffer]
  ;; Attach format on save functionality to the current buffer
  (local augroup (vim.api.nvim_create_augroup (.. :LspFormat. buffer) {}))
  (vim.api.nvim_create_autocmd :BufWritePost
                               {:group augroup : buffer :callback #(M.format)}))

M

