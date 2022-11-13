-- :fennel:1668308529
local has_colorizer_3f, colorizer = pcall(require, "colorizer")
if has_colorizer_3f then
  return colorizer.setup()
else
  return nil
end