local ok, _ = pcall(require, "tokyonight")
if not ok then
  return
end

-- Sets the global variable
local g = function(option, value)
  vim.g[option] = value
end

local tokyonight_settings = {
  -- Make functions italic
  tokyonight_italic_functions = true,
  -- Enable this to disable setting the background color
  tokyonight_transparent = true,
  -- Sidebar like windows like NvimTree get a transparent background
  tokyonight_transparent_sidebar = true,
}

for option, value in pairs(tokyonight_settings) do
  g(option, value)
end

-- Load the colorscheme
vim.cmd("colorscheme tokyonight")
