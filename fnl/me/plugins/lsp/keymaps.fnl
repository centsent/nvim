(local M {})

(set M.keys
     [{1 :ga
       2 #(vim.lsp.buf.code_action)
       :desc "Code Action"
       :mode [:n :v]
       :has :codeAction}
      {1 :gd 2 #(vim.lsp.buf.definition) :desc "Go to definition"}
      {1 :gi 2 #(vim.lsp.buf.implementation) :desc "Go to implementation"}
      {1 :gr 2 #(vim.lsp.buf.rename) :desc :Rename :has :rename}
      {1 :gD 2 #(vim.lsp.buf.type_definition) :desc "Go to Type Definition"}
      {1 :gh 2 #(vim.lsp.buf.hover) :desc :Hover}
      {1 :gn 2 #(vim.diagnostic.goto_next) :desc "Next diagnostic"}
      {1 :gp 2 #(vim.diagnostic.goto_prev) :desc "Prev diagnostic"}])

(fn parse-keymaps [keys]
  (local Keys (require :lazy.core.handler.keys))
  (local keymaps {})
  (each [_ value (ipairs keys)]
    (local keymap (Keys.parse value))
    (local rhs (. keymap 2))
    (local no-rhs (or (= rhs vim.NIL) (= rhs false)))
    (if no-rhs
        (tset keymaps keymap.id nil)
        (tset keymaps keymap.id keymap)))
  keymaps)

(fn set-keymaps [client buffer keymaps]
  (local LazyKeys (require :lazy.core.handler.keys))
  (each [_ keys (pairs keymaps)]
    (local no-provider (or (not keys.has)
                           (. client.server_capabilities
                              (.. keys.has :Provider))))
    (when no-provider
      (local opts (LazyKeys.opts keys))
      (set opts.has nil)
      (set opts.silent true)
      (set opts.buffer buffer)
      (local mode (or keys.mode :n))
      (local lhs (. keys 1))
      (local rhs (. keys 2))
      (vim.keymap.set mode lhs rhs opts))))

(fn M.on-attach [client buffer]
  (local keymaps (parse-keymaps M.keys))
  (set-keymaps client buffer keymaps))

M

