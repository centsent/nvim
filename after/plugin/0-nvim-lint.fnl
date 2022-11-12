(let [(has_lint? lint) (pcall require :lint)]
  (when has_lint?
    (local phpcs (require :lint.linters.phpcs))
    (set phpcs.args [ 
      "-q"
      "--report=json"
      "--standard=PSR12"
      "-"
    ])

    (set  lint.linters_by_ft {
      :lua ["luacheck" "codespell"]
      :sh ["shellcheck"]
      :java ["codespell"]
      :javascript ["eslint"]
      :typescript ["eslint"]
      :vue ["eslint"]
      :go ["golangci-lint"]
      :python ["flake8"]
      :yaml ["yamllint"]
      :gitcommit ["codespell"]
      ; Install phpcs via composer:
      ; $ composer global require squizlabs/php_codesniffer
      ; and make sure global vendor binaries directory is in $PATH
      :php ["phpcs"]
      :ruby ["rubocop"]
  })

  (vim.api.nvim_create_autocmd ["BufEnter" "BufWritePost" "BufLeave"] {
    :group (vim.api.nvim_create_augroup "lint" { :clear true })
    :callback (lambda [] 
                  (lint.try_lint))
  })))
