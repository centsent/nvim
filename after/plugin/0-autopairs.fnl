(let [(has_autopairs? autopairs) (pcall require :nvim-autopairs)]
  (when has_autopairs?
    (autopairs.setup {})))

