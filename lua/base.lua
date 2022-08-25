-- Sets the global value of an option
local o = function(option, value)
  vim.api.nvim_set_option(option, value)
end

-- Set default encoding to UTF-8
local default_encoding = "utf-8"
-- String-encoding used internally and for |RPC| communication.
o("encoding", default_encoding)
-- The encoding written to a file
o("fileencoding", default_encoding)
-- No backup
o("backup", false)
-- No swapfilw
o("swapfile", false)
-- Do not make a backup before overwriting a file.
o("writebackup", false)
-- Enable persistent undo
o("undofile", true)
-- Prefer Unix over Windows Over MacOS formats
o("fileformats", "unix,dos,mac")
-- Automatically read changed files
o("autoread", true)
-- Show line number
o("number", true)
-- Show the window title
o("title", true)
-- Show me what I'm typing
o("showcmd", true)
-- More spaces for displaying messages
o("cmdheight", 2)
-- Copy indent from current line when starting a new line
o("autoindent", true)
-- Convert tabs to spaces
o("expandtab", true)
-- The number of spaces inserted for each indentation
o("shiftwidth", 2)
-- A <Tab> in front of a line inserts blanks according to 'shiftwidth'
o("smarttab", true)
-- Insert two spaces for a tab
o("tabstop", 2)
-- Case insensitive searching UNLESS /C or capital in search
o("ignorecase", true)
-- Override the 'ignorecase' option if the search pattern contains upper case characters
o("smartcase", true)
-- Highlight the current line
o("cursorline", true)
-- Highlight the current column
o("cursorcolumn", true)
-- Show the line and column number of the cursor position
o("ruler", true)
-- Display lines as one long line
o("wrap", false)
-- Minimal number of screen lines to keep above and below the cursor.
o("scrolloff", 8)
-- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
o("sidescrolloff", 8)
-- Time to wait for a mapped sequence to complete (in milliseconds)
o("timeoutlen", 1000)

-- Append `node_modules` to `wildcards`, no expanding, completing for `node_modules`
vim.opt.wildignore:append({ "*/node_modules/*" })
