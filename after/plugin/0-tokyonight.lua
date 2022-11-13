-- :fennel:1668308243
local has_tokyonight_3f, tokyonight = pcall(require, "tokyonight")
if has_tokyonight_3f then
  local tokyonight_settings = {
    tokyonight_transparent_sidebar = true,
    transparent = true,
    styles = { functions = "italic", sidebar = "transparent" },
  }
  tokyonight.setup(tokyonight_settings)
  return vim.cmd("colorscheme tokyonight")
else
  return nil
end
