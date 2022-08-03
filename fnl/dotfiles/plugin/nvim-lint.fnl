(module dotfiles.plugin.nvim-lint
  {autoload {lint lint}})

(set lint.linters_by_ft {:lua [:luacheck]
                         })

(vim.cmd "au BufWritePost,BufEnter <buffer> lua require('lint').try_lint()")
