(let [(has_colorizer? colorizer) (pcall require :colorizer)]
  (when has_colorizer?
    (colorizer.setup)))

