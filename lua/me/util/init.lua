-- :fennel:1679549866
local M = {}
M.has = function(plugin)
  local lazy = require("lazy.core.config")
  return (lazy.plugins[plugin] ~= nil)
end
M["on-very-lazy"] = function(fun)
  local function _1_()
    return fun()
  end
  return vim.api.nvim_create_autocmd("User", {pattern = "VeryLazy", callback = _1_})
end
M.load = function(mod)
  local util = require("lazy.core.util")
  local function on_error(msg)
    local cache = require("lazy.core.cache")
    local modpath = cache.find(mod)
    if modpath then
      return util.error(msg)
    else
      return nil
    end
  end
  local function _3_()
    return require(mod)
  end
  return util.try(_3_, {msg = ("Failed loading " .. mod), on_error = on_error})
end
M["on-attach"] = function(on_attach)
  local function _4_(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    return on_attach(client, buffer)
  end
  return vim.api.nvim_create_autocmd("LspAttach", {callback = _4_})
end
M["get-formatter"] = function()
  local ok_3f, formatter_config = pcall(require, "formatter.config")
  if ok_3f then
    local formatters = formatter_config.values.filetype
    local ft = vim.bo.filetype
    return formatters[ft]
  else
    return nil
  end
end
M["get-formatter-name"] = function()
  local formatter = M["get-formatter"]()
  if formatter then
    local names = {}
    for _, fmt_fn in ipairs(formatter) do
      local formatter0 = fmt_fn()
      if formatter0 then
        local name = (formatter0.name or formatter0.exe)
        do end (names)[(#names + 1)] = name
      else
      end
    end
    return table.concat(names, ", ")
  else
    return ""
  end
end
M["get-linter"] = function()
  local has_lint_3f, lint = pcall(require, "lint")
  if has_lint_3f then
    return lint.linters_by_ft[vim.bo.filetype]
  else
    return nil
  end
end
M["get-linter-name"] = function()
  local linter = M["get-linter"]()
  if linter then
    return table.concat(linter, ", ")
  else
    return ""
  end
end
M["is-loaded"] = function(plugin)
  return ((require("lazy.core.config")).plugins[plugin]._.loaded ~= nil)
end
return M