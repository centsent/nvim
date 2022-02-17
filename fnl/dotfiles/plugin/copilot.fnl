(module dotfiles.plugin.copilot
  {autoload {util dotfiles.util}})

;; Use <c-l> instead of <tab> to accept copilot's suggestion.
(set vim.g.copilot_no_tab_map true)
(util.imap "<c-l>" "copilot#Accept('<CR>')" {:silent true :expr true :script true})
