(let [(has_surround? surround) (pcall require :nvim-surround)]
  (when has_surround?
    (surround.setup {})))
