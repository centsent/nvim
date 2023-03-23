(fn set-diagnostics-icons [icons]
  ;; Set diagnostic icons for each type
  (each [type icon (pairs icons)]
    (local name (.. :DiagnosticSign type))
    (vim.fn.sign_define name {:text icon :texthl name :numhl name})))

(fn get-capabilities []
  ;; Get the capabilities of the LSP client
  (local capabilities (vim.lsp.protocol.make_client_capabilities))
  (local cmp (require :cmp_nvim_lsp))
  (cmp.default_capabilities capabilities))

(fn config [_ settings]
  "Configure LSP settings and setup servers"
  (local servers settings.servers)

  (fn on-attach [client buffer]
    (local keymaps (require :me.plugins.lsp.keymaps))
    (local format (require :me.plugins.lsp.format))
    (keymaps.on-attach client buffer)
    (format.on-attach client buffer)
    (when client.server_capabilities.documentSymbolProvider
      (local navic (require :nvim-navic))
      (navic.attach client buffer)))

  (fn setup [server]
    (local capabilities (get-capabilities))
    ;; Setup the LSP server with the provided options
    (local old-opts {:capabilities (vim.deepcopy capabilities)})
    (local new-opts (or (. servers server) {}))
    (local server-opts (vim.tbl_deep_extend :force old-opts new-opts))
    (local setup-server (. settings.setup server))
    (when setup-server
      (pcall setup-server server server-opts))
    (local lspconfig (require :lspconfig))
    ((. lspconfig server :setup) server-opts))

  (fn setup-mason-lsp []
    ;; Initialize and setup Mason LSP
    (local ensure_installed {})
    (local mlsp (require :mason-lspconfig))
    (each [server server-opts (pairs servers)]
      (when server-opts
        (local available (mlsp.get_available_servers))
        (local is-not-mason-server
               (and (not= server-opts.mason false)
                    (not (vim.tbl_contains available server))))
        (if is-not-mason-server
            (setup server)
            (tset ensure_installed (+ (length ensure_installed) 1) server))))
    (mlsp.setup {: ensure_installed})
    (mlsp.setup_handlers [setup]))

  ((. (require :me.util) :on-attach) on-attach)
  (set-diagnostics-icons (. (require :me.config) :icons :diagnostics))
  (setup-mason-lsp))

(local dependencies [;; Portable package manager for Neovim that runs everywhere Neovim runs.
                     {1 :williamboman/mason.nvim
                      :opts {:max_concurrent_installers 10}}
                     ;; Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
                     :williamboman/mason-lspconfig.nvim
                     ;; Standalone UI for nvim-lsp progress
                     :j-hui/fidget.nvim
                     ;; Simple winbar/statusline plugin that shows your current code context
                     :SmiteshP/nvim-navic
                     ;; LSP signature hint as you type
                     {1 :ray-x/lsp_signature.nvim
                      :opts {:noice true :padding " "}}
                     ;; Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
                     :mfussenegger/nvim-jdtls])

[{;; Configs for neovim lsp client
  1 :neovim/nvim-lspconfig
  :opts {:autoformat true
         :setup {}
         :servers {:bashls {}
                   :clangd {}
                   :csharp_ls {}
                   :cssls {}
                   :cmake {}
                   :dockerls {}
                   :fennel_language_server {:mason false
                                            :settings {:fennel {:diagnostics {:globals [:vim]}}}}
                   :html {}
                   :julials {}
                   :marksman {}
                   :pyright {}
                   :solargraph {}
                   :taplo {}
                   :vimls {}
                   :volar {}}}
  : config
  : dependencies
  :event [:BufReadPost :BufNewFile]}
 ;; import extra lsp plugin specs
 {:import :me.plugins.extras.lsp}]

