(let [(has-leap? leap) (pcall require :leap)]
  (when has-leap?
    (leap.add_default_mappings)))

