local has_lint, lint = pcall(require, "lint")
if not has_lint then
  return
end

local with = function(fn)
  return function()
    fn()
  end
end

lint.linters_by_ft = {
  lua = { "luacheck", "codespell" },
  sh = { "shellcheck" },
  java = { "codespell" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  vue = { "eslint" },
  go = { "golangci-lint" },
  python = { "flake8" },
  yaml = { "yamllint" },
  gitcommit = { "codespell" },
  -- Install phpcs via composer:
  -- $ composer global require squizlabs/php_codesniffer
  -- and make sure global vendor binaries directory is in $PATH
  php = { "phpcs" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufLeave" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = with(lint.try_lint),
})
