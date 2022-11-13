-- :fennel:1668306980
local has_autopairs_3f, autopairs = pcall(require, "nvim-autopairs")
if has_autopairs_3f then
  return autopairs.setup({})
else
  return nil
end