(fn set-option [option value]
  (vim.api.nvim_set_option option value))

(fn create-augroup [name]
  (vim.api.nvim_create_augroup name {:clear true}))

(fn with [func]
  (lambda []
    (func)))

(fn get_servers []
  [:bashls
   :clangd
   :csharp_ls
   :cssls
   :cmake
   :dockerls
   :gopls
   :html
   :jsonls
   :julials
   :marksman
   :phpactor
   :pyright
   :rust_analyzer
   :solargraph
   :sumneko_lua
   :taplo
   :tsserver
   :vimls
   :volar
   :yamlls])

(fn buf-formatting []
  (local formatter (. (require :utils) :get_formatter))
  (when (not formatter)
    (vim.lsp.buf.format {:async true})))

(fn format-on-save [client bufnr]
  (when client.server_capabilities.documentFormattingProvider
    (local augroup (create-augroup :LspFormatting))
    (vim.api.nvim_create_autocmd :BufWritePost
                                 {:group augroup
                                  :buffer bufnr
                                  :callback buf-formatting})))

(fn open-diagnostic-float []
  (vim.diagnostic.open_float nil {:focusable false}))

(fn show-diagnostic-on-focus [client bufnr]
  ;; Set updatetime for CursorHold ; 300ms of no cursor movement to trigger CursorHold
  (set-option :updatetime 300)
  (local augroup (create-augroup :LspDiagnostic))
  (vim.api.nvim_create_autocmd :CursorHold
                               {:group augroup
                                :buffer bufnr
                                :callback open-diagnostic-float})
  ;; have a fixed column for the diagnostics to appear in 
  ;; this removes the jitter when warnings/errors flow in
  (set-option :signcolumn :yes))

(fn document-highlight [client bufnr]
  (when client.server_capabilities.documentHighlightProvider
    (local augroup (create-augroup :LspDocumentHighlight))
    (vim.api.nvim_create_autocmd [:CursorHold :CursorHoldI]
                                 {:group augroup
                                  :buffer bufnr
                                  :callback (with vim.lsp.buf.document_highlight)})
    (vim.api.nvim_create_autocmd :CursorMoved
                                 {:group augroup
                                  :buffer bufnr
                                  :callback (with vim.lsp.buf.clear_references)})))

(fn set-keymaps [bufnr]
  (local bufopts {:noremap true :silent true :buffer bufnr})
  (local keymaps {:ga (with vim.lsp.buf.code_action)
                  :gd (with vim.lsp.buf.definition)
                  :gi (with vim.lsp.buf.implementation)
                  :gr (with vim.lsp.buf.rename)
                  :gtd (with vim.lsp.buf.type_definition)
                  :gh (with vim.lsp.buf.hover)
                  :gn (with vim.diagnostic.goto_next)
                  :gp (with vim.diagnostic.goto_prev)})
  ((. (require :keymaps) :load_keymaps_for_mode) :n keymaps bufopts))

(fn setup-lsp-signature [client bufnr]
  (let [(has-lsp-signature? lsp-signature) (pcall require :lsp_signature)]
    (when has-lsp-signature?
      (lsp-signature.setup {} bufnr))))

(fn setup-navic [client bufnr]
  (let [(has-navic? navic) (pcall require :nvim-navic)]
    (when (and has-navic? client.server_capabilities.documentSymbolProvider)
      (navic.attach client bufnr))))

(fn setup-fidget [client bufnr]
  (let [(has-fidget? fidget) (pcall require :fidget)]
    (when has-fidget?
      (fidget.setup {}))))

(fn on_attach [client bufnr]
  (set-keymaps bufnr)
  (show-diagnostic-on-focus client bufnr)
  (format-on-save client bufnr)
  (document-highlight client bufnr)
  (setup-lsp-signature client bufnr)
  (setup-navic client bufnr)
  (setup-fidget))

(fn make_capabilities []
  (var capabilities (vim.lsp.protocol.make_client_capabilities))
  (let [(has_cmp? cmp) (pcall require :cmp_nvim_lsp)]
    (when has_cmp?
      (set capabilities (cmp.default_capabilities capabilities)))))

(local signs {:Error " " :Warn " " :Hint " " :Info " "})

(fn setup_signs []
  (each [type icon (pairs signs)]
    (local hl (.. :DiagnosticSign type))
    (vim.fn.sign_define hl {:text icon :texthl hl :numhl hl})))

{: signs : setup_signs : get_servers : on_attach}

