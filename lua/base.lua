-- Sets the global value of an option
local o = function(option, value)
  vim.api.nvim_set_option(option, value)
end

-- Set default encoding to UTF-8
local default_encoding = "utf-8"
local global_options = {
  -- String-encoding used internally and for |RPC| communication.
  encoding = default_encoding,
  -- The encoding written to a file
  fileencoding = default_encoding,
  -- Prefer Unix over Windows Over MacOS formats
  fileformats = "unix,dos,mac",
  -- No backup
  backup = false,
  -- No swapfile
  swapfile = false,
  -- Do not make a backup before overwriting a file.
  writebackup = false,
  -- Enable persistent undo
  undofile = true,
  -- Automatically read changed files
  autoread = true,
  -- Show line number
  number = true,
  -- Show the window title
  title = true,
  -- Show me what I'm typing
  showcmd = true,
  -- More spaces for displaying messages
  cmdheight = 2,
  -- Copy indent from current line when starting a new line
  autoindent = true,
  -- Convert tabs to spaces
  expandtab = true,
  -- The number of spaces inserted for each indentation
  shiftwidth = 2,
  -- A <Tab> in front of a line inserts blanks according to 'shiftwidth'
  smarttab = true,
  -- Insert two spaces for a tab
  tabstop = 2,
  -- Case insensitive searching UNLESS /C or capital in search
  ignorecase = true,
  -- Override the 'ignorecase' option if the search pattern contains upper case characters
  smartcase = true,
  -- Highlight the current line
  cursorline = true,
  -- Highlight the current column
  cursorcolumn = true,
  -- Show the line and column number of the cursor position
  ruler = true,
  -- Display lines as one long line
  wrap = false,
  -- Minimal number of screen lines to keep above and below the cursor.
  scrolloff = 8,
  -- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
  sidescrolloff = 8,
  -- Time to wait for a mapped sequence to complete (in milliseconds)
  timeoutlen = 1000,
}

for option, value in pairs(global_options) do
  o(option, value)
end

-- Append `node_modules` to `wildcards`, no expanding, completing for `node_modules`
vim.opt.wildignore:append({ "*/node_modules/*" })
