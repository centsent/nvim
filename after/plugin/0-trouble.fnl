(let [(has_trouble? trouble) (pcall require :trouble)]
  (when has_trouble?
    (trouble.setup {
      :position "right"
      :use_diagnostic_signs true
    })))
