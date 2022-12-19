(let [(has_lint? lint) (pcall require :lint)]
  (when has_lint?
    (fn setup-phpcs []
      (local phpcs (require :lint.linters.phpcs))
      (set phpcs.args [:-q :--report=json :--standard=PSR12 "-"]))

    (fn create-lint-autocmd []
      (local events [:BufEnter :BufWritePost :BufLeave])
      (local augroup (vim.api.nvim_create_augroup :NvimLint {:clear true}))
      (local opts {:group augroup :callback #(lint.try_lint)})
      (vim.api.nvim_create_autocmd events opts))

    (local linters {:lua [:luacheck :codespell]
                    :sh [:shellcheck]
                    :java [:codespell]
                    :javascript [:eslint]
                    :typescript [:eslint]
                    :vue [:eslint]
                    :go [:golangci-lint]
                    :python [:flake8]
                    :yaml [:yamllint]
                    :gitcommit [:codespell]
                    ;; Install phpcs via composer:
                    ;; $ composer global require squizlabs/php_codesniffer
                    ;; and make sure global vendor binaries directory is in $PATH
                    :php [:phpcs]
                    :ruby [:rubocop]
                    :dockerfile [:hadolint]
                    :fennel [:fennel]})
    (setup-phpcs)
    (set lint.linters_by_ft linters)
    (create-lint-autocmd)))

