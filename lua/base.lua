vim.cmd("autocmd!")

local o = function(option, value)
  vim.api.nvim_set_option(option, value)
end

local wo = function(option, value)
  vim.api.nvim_win_set_option(0, option, value)
end

wo("number", true)

-- Set default encoding to UTF-8
local default_encoding = "utf-8"
o("encoding", default_encoding)
o("fileencoding", default_encoding)

o("title", true)
o("autoindent", true)
-- Show me what I'm typing
o("showcmd", true)
-- No backup
o("backup", false)
-- Prefer Unix over Windows Over MacOS formats
o("fileformats", "unix,dos,mac")
-- Automatically read changed files
o("autoread", true)
-- Always show current position
o("cursorline", true)
o("cursorcolumn", true)
o("ruler", true)
o("colorcolumn", "80")
-- highlights
o("termguicolors", true)
o("winblend", 0)
o("wildoptions", "pum")
o("pumblend", 5)
o("background", "dark")

o("cmdheight", 1)
o("laststatus", 3)

o("smarttab", true)
o("breakindent", true)
o("shiftwidth", 2)
o("tabstop", 2)
o("wrap", false)

vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Case insensitive searching UNLESS /C or capital in search
o("ignorecase", true)
