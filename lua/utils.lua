-- :fennel:1668259270
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
return {get_formatter = get_formatter}