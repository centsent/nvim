(fn config [_ settings]
  (local util (require :me.util))
  (util.on-attach (fn [client buffer]
                    (local keymaps (require :me.plugins.lsp.keymaps))
                    (keymaps.on-attach client buffer)))

  (fn get-capabilities []
    (local capabilities (vim.lsp.protocol.make_client_capabilities))
    (local cmp (require :cmp_nvim_lsp))
    (cmp.default_capabilities capabilities))

  (local servers settings.servers)
  (local capabilities (get-capabilities))

  (fn setup [server]
    (local old-opts {:capabilities (vim.deepcopy capabilities)})
    (local new-opts (or (. servers server) {}))
    (local server-opts (vim.tbl_deep_extend :force old-opts new-opts))
    (local server-setup (. settings.setup server))
    (when server-setup
      (pcall server-setup server server-opts))
    (local lspconfig (require :lspconfig))
    ((. (. lspconfig server) :setup) server-opts))

  (fn setup-mason-lsp []
    (local ensure_installed {})
    (each [server server-opts (pairs servers)]
      (when server-opts
        (tset ensure_installed (+ (length ensure_installed) 1) server)))
    (local mlsp (require :mason-lspconfig))
    (mlsp.setup {: ensure_installed})
    (mlsp.setup_handlers [setup]))

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
                     :ray-x/lsp_signature.nvim
                     ;; Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
                     :mfussenegger/nvim-jdtls])

;; Configs for neovim lsp client
{1 :neovim/nvim-lspconfig
 :opts {:autoformat true
        :setup {}
        :servers {:bashls {}
                  :clangd {}
                  :csharp_ls {}
                  :cssls {}
                  :cmake {}
                  :dockerls {}
                  :fennel_language_server {:settings {:fennel {:diagnostics {:globals [:vim]}}}}
                  :gopls {}
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

