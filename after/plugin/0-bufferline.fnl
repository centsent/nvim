(let [(has-bufferline? bufferline) (pcall require :bufferline)]
  (when has-bufferline?
    (local options {:mode :tabs
                    :show_buffer_close_icons true
                    :show_close_icon false
                    :indicator {:style :underline}})
    (bufferline.setup {: options})))

