local has_bufferline, bufferline = pcall(require, "bufferline")
if not has_bufferline then
  return
end

local settings = {
  options = {
    mode = "tabs",
    show_buffer_close_icons = false,
  },
}

bufferline.setup(settings)
