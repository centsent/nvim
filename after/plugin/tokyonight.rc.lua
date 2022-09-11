local has_tokyonight, tokyonight = pcall(require, "tokyonight")
if not has_tokyonight then
  return
end

local tokyonight_settings = {
  tokyonight_transparent_sidebar = true,
  -- Enable this to disable setting the background color
  transparent = true,
  styles = {
    -- Make functions italic
    functions = "italic",
    -- Sidebar like windows like NvimTree get a transparent background
    sidebar = "transparent",
  },
}

local setup = function()
  tokyonight.setup(tokyonight_settings)

  -- Load the colorscheme
  vim.cmd("colorscheme tokyonight")
end

setup()
