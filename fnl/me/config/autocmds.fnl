(import-macros {: ieach!} :macros)

(fn augroup [name]
  (vim.api.nvim_create_augroup (.. :me_ name) {:clear true}))

(fn create-autocmd [autocmd]
  (vim.api.nvim_create_autocmd autocmd.events autocmd.opts))

(fn set-lastloc []
  (local mark (vim.api.nvim_buf_get_mark 0 "\""))
  (local lcount (vim.api.nvim_buf_line_count 0))
  (local last-mark (. mark 1))
  (when (and (> last-mark 0) (<= last-mark lcount))
    (pcall vim.api.nvim_win_set_cursor 0 mark)))

(fn close-with-q [event]
  (. vim.bo event.buf :buflisted))

(local autocmds [;; Highlight on yank
                 {:events [:TextYankPost]
                  :opts {:group (augroup :highlight_yank)
                         :callback #(vim.highlight.on_yank)}}
                 ;; Go to last loc when opening a buffer
                 {:events [:BufReadPost]
                  :opts {:group (augroup :last_loc) :callback set-lastloc}}
                 ;; Close some filetypes with <q>
                 {:events [:FileType]
                  :opts {:group (augroup :close_with_q)
                         :pattern [:PlenaryTestPopup
                                   :help
                                   :lspinfo
                                   :man
                                   :notify
                                   :qf
                                   :spectre_panel
                                   :startuptime]
                         :callback close-with-q}}])

(ieach! autocmds create-autocmd)

