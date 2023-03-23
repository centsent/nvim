-- :fennel:1679568740
local function set_option(option, value)
  return vim.api.nvim_set_option(option, value)
end
local default_encoding = "utf-8"
local options = {encoding = default_encoding, fileencoding = default_encoding, fileformats = "unix,dos,mac", undofile = true, autoread = true, number = true, title = true, showcmd = true, cmdheight = 2, autoindent = true, expandtab = true, shiftwidth = 2, smarttab = true, tabstop = 2, ignorecase = true, smartcase = true, cursorline = true, cursorcolumn = true, ruler = true, scrolloff = 8, sidescrolloff = 8, timeoutlen = 1000, clipboard = "unnamedplus", termguicolors = true, wrap = false, writebackup = false, backup = false, swapfile = false}
for option, value in pairs(options) do
  set_option(option, value)
end
return nil