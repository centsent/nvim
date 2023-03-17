-- :fennel:1679055785
local M = {}
M.autoformat = true
M.toggle = function()
  M.autoformat = not M.autoformat
  local lazy_util = require("lazy.core.util")
  if M.autoformat then
    return lazy_util.info("Enabled format on save", {title = "LspFormat"})
  else
    return lazy_util.warn("Disabled format on save", {title = "LspFormat"})
  end
end
M.format = function()
  if M.autoformat then
    local _local_2_ = require("me.util")
    local get_formatter = _local_2_["get-formatter"]
    local formatter = get_formatter()
    if (nil ~= formatter) then
      return vim.cmd("FormatWrite")
    else
      return vim.lsp.buf.format()
    end
  else
    return nil
  end
end
M["on-attach"] = function(_, buffer)
  local augroup = vim.api.nvim_create_augroup(("LspFormat." .. buffer), {})
  local function _5_()
    return M.format()
  end
  return vim.api.nvim_create_autocmd("BufWritePost", {group = augroup, buffer = buffer, callback = _5_})
end
return M