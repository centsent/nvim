local utils = {}
local uv = vim.loop

utils.safe_require = function(mod)
  return pcall(require, mod)
end

utils.is_executable = function(expr)
  return vim.fn.executable(expr) == 1
end

utils.with = function(fn)
  return function()
    fn()
  end
end

utils.is_file = function(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "file" or false
end

utils.is_directory = function(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory" or false
end

utils.get_formatter = function()
  local has_fmtconfig, fmtconfig = pcall(require, "formatter.config")
  if not has_fmtconfig then
    return nil
  end

  local formatters = fmtconfig.values.filetype
  local ft = vim.bo.filetype
  return formatters[ft]
end

utils.get_formatter_name = function()
  local formatters = utils.get_formatter()
  if not formatters then
    return ""
  end

  local names = {}
  for _, fmt_fn in ipairs(formatters) do
    local formatter = fmt_fn()
    if formatter then
      names[#names + 1] = formatter.name or formatter.exe
    end
  end

  return table.concat(names, ", ")
end

utils.get_linter = function()
  local has_lint, lint = pcall(require, "lint")
  if not has_lint then
    return nil
  end

  return lint.linters_by_ft[vim.bo.filetype]
end

utils.get_linter_name = function()
  local linter = utils.get_linter()
  if not linter then
    return ""
  end

  return table.concat(linter, ", ")
end

return utils
