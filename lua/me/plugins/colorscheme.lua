-- :fennel:1678698650
local function tokyonight_config(_, opts)
  local tokyonight = require("tokyonight")
  tokyonight.setup(opts)
  return vim.cmd("colorscheme tokyonight")
end
return {{lazy = true, opts = {style = "moon", tokyonight_transparent_sidebar = true, transparent = true, styles = {functions = {italic = true}, comments = {italic = true}, keywords = {italic = true}, sidebars = "transparent", float = "transparent"}}, config = tokyonight_config, "folke/tokyonight.nvim"}}