(fn set_option [option value]
   (vim.api.nvim_set_option option value))

(fn create_augroup [name]
  (vim.api.nvim_create_augroup name {:clear true}))

(fn with [func]
  (lambda []
    (func)))

(fn get_servers []
   [
    "bashls"
    "ccls"
    "clangd"
    "csharp_ls"
    "cssls"
    "cmake"
    "dockerls"
    "gopls"
    "html"
    "jsonls"
    "julials"
    "marksman"
    "phpactor"
    "pyright"
    "rust_analyzer"
    "solargraph"
    "sumneko_lua"
    "taplo"
    "tsserver"
    "vimls"
    "volar"
    "yamlls"
   ])

(fn buf_formatting []
   (local formatter (. (require :utils) :get_formatter)) 
   (when (not formatter)
     (vim.lsp.buf.format {:async true}) ))

(fn format_on_save [client bufnr]
  (when client.server_capabilities.documentFormattingProvider
    (local augroup (create_augroup "LspFormatting"))
    (vim.api.nvim_create_autocmd "BufWritePost" {
      :group augroup
      :buffer bufnr
      :callback buf_formatting
    })))

(fn show_diagnostic_on_focus [client bufnr]
  ; Set updatetime for CursorHold
  ; 300ms of no cursor movement to trigger CursorHold
  (set_option "updatetime" 300)
  (local augroup (create_augroup "LspDiagnostic"))
  (vim.api.nvim_create_autocmd "CursorHold" {
    :group augroup
    :buffer bufnr
    :callback (lambda []
      (vim.diagnostic.open_float nil {:focusable false}))})
  ; have a fixed column for the diagnostics to appear in
  ; this removes the jitter when warnings/errors flow in
  (set_option "signcolumn" "yes"))

(fn document_highlight [client bufnr]
  (when client.server_capabilities.documentHighlightProvider
    (local augroup (create_augroup "LspDocumentHighlight"))
    (vim.api.nvim_create_autocmd ["CursorHold" "CursorHoldI"] {
      :group augroup
      :buffer bufnr
      :callback (with vim.lsp.buf.document_highlight)
    })
    (vim.api.nvim_create_autocmd "CursorMoved" {
      :group augroup
      :buffer bufnr
      :callback (with vim.lsp.buf.clear_references)
    })))

(fn set_keymaps [bufnr]
  (local bufopts {:noremap true :silent true :buffer bufnr})
  (local keymaps {
    "ga" (with vim.lsp.buf.code_action)
    "gd" (with vim.lsp.buf.definition)
    "gi" (with vim.lsp.buf.implementation)
    "gr" (with vim.lsp.buf.rename)
    "gtd" (with vim.lsp.buf.type_definition)
    "gh" (with vim.lsp.buf.hover)
    "gn" (with vim.diagnostic.goto_next)
    "gp" (with vim.diagnostic.goto_prev)
  })

  ((. (require :keymaps) :load_keymaps_for_mode) "n" keymaps bufopts))

(fn on_attach [client bufnr]
  (set_keymaps bufnr)
  (show_diagnostic_on_focus client bufnr)
  (format_on_save client bufnr)
  (document_highlight client bufnr))

(fn make_capabilities []
  (var capabilities (vim.lsp.protocol.make_client_capabilities))
  (let [(has_cmp? cmp) (pcall require :cmp_nvim_lsp)]
    (when has_cmp?
      (set capabilities (cmp.default_capabilities capabilities)))))

(local signs { :Error " " :Warn " " :Hint " " :Info " " })

(fn setup_signs []
  (each [type icon (pairs signs)]
    (local hl (.. "DiagnosticSign" type))
    (vim.fn.sign_define hl {:text icon :texthl hl :numhl hl})))

:return {
  :signs signs
  :setup_signs setup_signs
  :get_servers get_servers
  :on_attach on_attach
}
