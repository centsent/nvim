local logger = {}
local default_opts = {
  title = "nvim-config",
}

local extend_opts = function(opts)
  return vim.tbl_deep_extend("force", default_opts, opts or {})
end

logger.trace = function(message, opts)
  vim.notify(message, vim.log.levels.TRACE, extend_opts(opts))
end

logger.debug = function(message, opts)
  vim.notify(message, vim.log.levels.DEBUG, extend_opts(opts))
end

logger.info = function(message, opts)
  vim.notify(message, vim.log.levels.INFO, extend_opts(opts))
end

logger.warn = function(message, opts)
  vim.notify(message, vim.log.levels.WARN, extend_opts(opts))
end

logger.error = function(message, opts)
  vim.notify(message, vim.log.levels.ERROR, extend_opts(opts))
end

return logger
