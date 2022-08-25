local ok, _ = pcall(require, "tokyonight")
if not ok then
  return
end

-- Sets the global variable
local g = function(name, value)
  vim.g[name] = value
end

-- Make functions italic
g("tokyonight_italic_functions", true)
-- Enable this to disable setting the background color
g("tokyonight_transparent", true)
-- Sidebar like windows like NvimTree get a transparent background
g("tokyonight_transparent_sidebar", true)
-- Load the colorscheme
vim.cmd("colorscheme tokyonight")
