(fn set-option [option value]
  (vim.api.nvim_set_option option value))

(fn create-augroup [name]
  (vim.api.nvim_create_augroup name {:clear true}))

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
   :lua_ls
   :marksman
   :phpactor
   :pyright
   :rust_analyzer
   :solargraph
   :taplo
   :tsserver
   :vimls
   :volar
   :yamlls])

(fn buf-formatting []
  (local {: get-formatter} (require :me.util))
  (local formatter (get-formatter))
  (when (not formatter)
    (vim.lsp.buf.format {:async true})))

(fn format-on-save [client bufnr]
  (when client.server_capabilities.documentFormattingProvider
    (local events :BufWritePost)
    (local augroup (create-augroup :LspFormatting))
    (local opts {:group augroup :buffer bufnr :callback #(buf-formatting)})
    (vim.api.nvim_create_autocmd events opts)))

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
                                  :callback #(vim.lsp.buf.document_highlight)})
    (vim.api.nvim_create_autocmd :CursorMoved
                                 {:group augroup
                                  :buffer bufnr
                                  :callback #(vim.lsp.buf.clear_references)})))

(fn set-keymaps [bufnr]
  (local bufopts {:noremap true :silent true :buffer bufnr})
  (local keymaps {:ga #(vim.lsp.buf.code_action)
                  :gd #(vim.lsp.buf.definition)
                  :gi #(vim.lsp.buf.implementation)
                  :gr #(vim.lsp.buf.rename)
                  :gtd #(vim.lsp.buf.type_definition)
                  :gh #(vim.lsp.buf.hover)
                  :gn #(vim.diagnostic.goto_next)
                  :gp #(vim.diagnostic.goto_prev)})
  (local {: load_keymaps_for_mode} (require :me.config.keymaps))
  (load_keymaps_for_mode :n keymaps bufopts))

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
  (setup-fidget)
  nil)

(fn make_capabilities []
  (var capabilities (vim.lsp.protocol.make_client_capabilities))
  (let [(has_cmp? cmp) (pcall require :cmp_nvim_lsp)]
    (when has_cmp?
      (set capabilities (cmp.default_capabilities capabilities)))
    capabilities))

(local signs {:Error " " :Warn " " :Hint " " :Info " "})

(fn setup_signs []
  (each [type icon (pairs signs)]
    (local hl (.. :DiagnosticSign type))
    (vim.fn.sign_define hl {:text icon :texthl hl :numhl hl})))

(fn config [opts]
  (local defualt-opts {: on_attach :capabilities (make_capabilities)})
  (vim.tbl_deep_extend :force defualt-opts (or opts {})))

{: signs : setup_signs : get_servers : on_attach : config : make_capabilities}

