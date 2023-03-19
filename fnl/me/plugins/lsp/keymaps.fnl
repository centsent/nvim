(local M {})

(set M.keys [{1 :ga
              2 #(vim.lsp.buf.code_action)
              :desc "Code Action"
              :mode [:n :v]
              :has :codeAction}
             {1 :gd 2 #(vim.lsp.buf.definition) :desc "Go to definition"}
             {1 :gD
              2 #(vim.lsp.buf.type_definition)
              :desc "Go to Type Definition"}
             {1 :gi
              2 #(vim.lsp.buf.implementation)
              :desc "Go to implementation"}
             {1 :gr 2 #(vim.lsp.buf.rename) :desc :Rename :has :rename}
             {1 :gk 2 #(vim.lsp.buf.hover) :desc :Hover}
             {1 :gK
              2 #(vim.lsp.buf.signature_help)
              :desc "Signature Help"
              :has :signatureHelp}
             {1 :gn 2 #(vim.diagnostic.goto_next) :desc "Next diagnostic"}
             {1 :gp 2 #(vim.diagnostic.goto_prev) :desc "Prev diagnostic"}
             {1 :gF
              2 #((. (require :me.plugins.lsp.format) :toggle))
              :desc "Toggle autoformat"}])

(fn parse-lazy-keymaps [keys]
  ;; Parse the lazy keymaps and set the appropriate key bindings
  (local LazyKeysHandler (require :lazy.core.handler.keys))
  (local lazy-keymaps {})
  (each [_ value (ipairs keys)]
    (local keymap (LazyKeysHandler.parse value))
    (local rhs (. keymap 2))
    (local no-rhs (or (= rhs vim.NIL) (= rhs false)))
    (if no-rhs
        (tset lazy-keymaps keymap.id nil)
        (tset lazy-keymaps keymap.id keymap)))
  lazy-keymaps)

(fn set-lazy-key [client buffer lazy-key]
  ;; Check if the provider is available and set the key binding if it is
  (local LazyKeysHandler (require :lazy.core.handler.keys))
  (local no-provider (or (not lazy-key.has)
                         (. client.server_capabilities
                            (.. lazy-key.has :Provider))))
  (when no-provider
    (local opts (LazyKeysHandler.opts lazy-key))
    (set opts.has nil)
    (set opts.silent true)
    (set opts.buffer buffer)
    (local mode (or lazy-key.mode :n))
    (local lhs (. lazy-key 1))
    (local rhs (. lazy-key 2))
    (vim.keymap.set mode lhs rhs opts)))

(fn set-keymaps [client buffer lazy-keymaps]
  ;; Set the keymaps for the LSP client and buffer
  (each [_ lazy-key (pairs lazy-keymaps)]
    (set-lazy-key client buffer lazy-key)))

(fn M.on-attach [client buffer]
  ;; Set keymaps for the LSP client when it attaches to a buffer
  (local lazy-keymaps (parse-lazy-keymaps M.keys))
  (set-keymaps client buffer lazy-keymaps))

M

