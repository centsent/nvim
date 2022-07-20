(module dotfiles.keymaps.lspconfig)

(def- command vim.cmd)

(defn custom-lsp-attach [client bufnr]
  "lspconfig keymaps"
  (defn- buf-set-keymap [...]
    (vim.api.nvim_buf_set_keymap bufnr ...))
  (defn- buf-set-option [...]
    (vim.api.nvim_buf_set_option bufnr ...))

  ; Enable completion triggered by <c-x><c-o>
  (buf-set-option "omnifunc" "v:lua.vim.lsp.omnifunc")

  ; Mappings
  (def- opts {:noremap true 
              :silent true })

  (buf-set-keymap "n" "gd" ":lua vim.lsp.buf.definition()<cr>" opts)
  (buf-set-keymap "n" "gi" ":lua vim.lsp.buf.implementation()<cr>" opts)
  (buf-set-keymap "n" "gr" ":lua vim.lsp.buf.rename()<cr>" opts)
  (buf-set-keymap "n" "gy" ":lua vim.lsp.buf.type_definition()<cr>" opts)
  (buf-set-keymap "n" "gh" ":lua vim.lsp.buf.hover()<cr>" opts)
  (buf-set-keymap "n" "gn" ":lua vim.diagnostic.goto_next()<cr>" opts)
  (buf-set-keymap "n" "gp" ":lua vim.diagnostic.goto_prev()<cr>" opts)
  (buf-set-keymap "n" "ge" ":lua vim.diagnostic.open_float()<cr>" opts)

  ; Set updatetime for CursorHold
  ; 300ms of no cursor movement to trigger CursorHold
  (command "set updatetime=300")
  ; Show diagnostic popup on CursorHold
  (command "autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })")
  ; have a fixed column for the diagnostics to appear in
  ; this removes the jitter when warnings/errors flow in
  (command "set signcolumn=yes")

  ; Format on save.
  (if client.resolved_capabilities.document_formatting
    (command "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")))
