-- :fennel:1679492006
local function config()
  local lint = require("lint")
  local function setup_phpcs()
    local phpcs = require("lint.linters.phpcs")
    phpcs.args = {"-q", "--report=json", "--standard=PSR12", "-"}
    return nil
  end
  local function create_lint_autocmd()
    local events = {"BufEnter", "BufWritePost", "BufLeave"}
    local augroup = vim.api.nvim_create_augroup("NvimLint", {clear = true})
    local opts
    local function _1_()
      return lint.try_lint()
    end
    opts = {group = augroup, callback = _1_}
    return vim.api.nvim_create_autocmd(events, opts)
  end
  local linters = {lua = {"luacheck", "codespell"}, sh = {"shellcheck"}, java = {"codespell"}, javascript = {"eslint"}, typescript = {"eslint"}, vue = {"eslint"}, go = {"golangcilint"}, python = {"ruff"}, yaml = {"yamllint"}, gitcommit = {"codespell"}, php = {"phpcs"}, ruby = {"rubocop"}, fennel = {"fennel"}}
  setup_phpcs()
  lint.linters_by_ft = linters
  return create_lint_autocmd()
end
return {config = config, event = {"BufWritePost"}, "mfussenegger/nvim-lint"}