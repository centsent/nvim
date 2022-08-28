local utils = {}
local uv = vim.loop

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

return utils
