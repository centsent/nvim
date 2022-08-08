(module dotfiles.plugin.nvim-lint
  {autoload {lint lint}})

(set lint.linters_by_ft {:lua [:luacheck :codespell]
                         :java [:codespell]
                         :sh [:shellcheck]
                         :markdown [:vale]
                         :html [:eslint]
                         :javascript [:eslint]
                         :rst [:vale]
                         :yaml [:yamllint]
                         :gitcommit [:codespell]})

(vim.cmd "au BufWritePost,BufEnter <buffer> lua require('lint').try_lint()")
