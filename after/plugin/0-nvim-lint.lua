-- :fennel:1668265993
local has_lint_3f, lint = pcall(require, "lint")
if has_lint_3f then
  local phpcs = require("lint.linters.phpcs")
  phpcs.args = {"-q", "--report=json", "--standard=PSR12", "-"}
  lint.linters_by_ft = {lua = {"luacheck", "codespell"}, sh = {"shellcheck"}, java = {"codespell"}, javascript = {"eslint"}, typescript = {"eslint"}, vue = {"eslint"}, go = {"golangci-lint"}, python = {"flake8"}, yaml = {"yamllint"}, gitcommit = {"codespell"}, php = {"phpcs"}, ruby = {"rubocop"}}
  local function _1_()
    return lint.try_lint()
  end
  return vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "BufLeave"}, {group = vim.api.nvim_create_augroup("lint", {clear = true}), callback = _1_})
else
  return nil
end