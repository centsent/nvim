-- :fennel:1668307095
local has_bufferline_3f, bufferline = pcall(require, "bufferline")
if has_bufferline_3f then
  return bufferline.setup({options = {mode = "tabs", show_buffer_close_icons = false}})
else
  return nil
end