(fn config []
  (local lint (require :lint))

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
                  :go [:golangcilint]
                  :python [:ruff]
                  :yaml [:yamllint]
                  :gitcommit [:codespell]
                  :php [:phpcs]
                  :ruby [:rubocop]
                  :fennel [:fennel]})
  (setup-phpcs)
  (set lint.linters_by_ft linters)
  (create-lint-autocmd))

{;; An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
 1 :mfussenegger/nvim-lint
 : config
 :event [:BufWritePost]}

