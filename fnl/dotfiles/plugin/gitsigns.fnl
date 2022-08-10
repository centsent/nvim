(module dotfiles.plugin.gitsigns
  {autoload {gitsigns gitsigns}})

(gitsigns.setup {:current_line_blame true})
(vim.cmd "set statusline+=%{get(b:,'gitsigns_status','')}")
