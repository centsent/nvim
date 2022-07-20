(module dotfiles.plugin.nvim-lint
  {autoload {lint lint}})

(vim.cmd "au BufWritePost <buffer> lua require('lint').try_lint()")
