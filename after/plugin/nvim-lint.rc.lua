local ok, lint = pcall(require, "lint")
if not ok then
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
  go = { "golangci-lint" },
  python = { "flake8" },
  yaml = { "yamllint" },
  gitcommit = { "codespell" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufLeave" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = with(lint.try_lint),
})
