local ok, _ = pcall(require, "tokyonight")
if not ok then
  return
end

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

vim.cmd("colorscheme tokyonight")
