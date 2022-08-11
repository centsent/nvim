local ok, lint = pcall(require, "lint")
if not ok then
  return
end

lint.linters_by_ft = {
  lua = { "luacheck", "codespell" },
  sh = { "shellcheck" },
  java = { "codespell" },
  javascritpt = { "eslint" },
  typescritpt = { "eslint" },
  go = { "golangci-lint" },
  python = { "flake8" },
  markdown = { "vale" },
  yaml = { "yamllint" },
  gitcommit = { "codespell" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})
