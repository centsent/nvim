local utils = {}

utils.is_executable = function(expr)
  return vim.fn.executable(expr) == 1
end

utils.with = function(fn)
  return function()
    fn()
  end
end

utils.is_file_exists = function(path)
  local f = io.open(path, "r")

  if f ~= nil then
    io.close(f)
    return true
  end

  return false
end

return utils
