-- :fennel:1668273086
local function get_formatter()
  local ok_3f, formatter_config = pcall(require, "formatter.config")
  if ok_3f then
    local formatters = formatter_config.values.filetype
    local ft = vim.bo.filetype
    return formatters[ft]
  else
    return nil
  end
end
local function get_formatter_name()
  local formatter = get_formatter()
  if formatter then
    local names = {}
    for _, fmt_fn in ipairs(formatter) do
      local formatter0 = fmt_fn()
      if formatter0 then
        names[(#names + 1)] = (formatter0.name or formatter0.exe)
      else
      end
    end
    return table.concat(names, ", ")
  else
    return ""
  end
end
local function get_linter()
  local has_lint_3f, lint = pcall(require, "lint")
  if has_lint_3f then
    return lint.linters_by_ft[vim.bo.filetype]
  else
    return nil
  end
end
local function get_linter_name()
  local linter = get_linter()
  if not linter then
    return ""
  else
    return table.concat(linter, ", ")
  end
end
return {get_linter = get_linter, get_linter_name = get_linter_name, get_formatter = get_formatter, get_formatter_name = get_formatter_name}