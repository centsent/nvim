-- :fennel:1668302820
local has_trouble_3f, trouble = pcall(require, "trouble")
if has_trouble_3f then
  return trouble.setup({position = "right", use_diagnostic_signs = true})
else
  return nil
end