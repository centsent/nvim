(let [(has_bufferline? bufferline) (pcall require :bufferline)]
  (when has_bufferline?
    (bufferline.setup {:options {:mode :tabs :show_buffer_close_icons false}})))

