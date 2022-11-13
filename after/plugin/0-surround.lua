-- :fennel:1668302906
local has_surround_3f, surround = pcall(require, "nvim-surround")
if has_surround_3f then
  return surround.setup({})
else
  return nil
end