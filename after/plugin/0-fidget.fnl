(let [(has-fidget? fidget) (pcall require :fidget)]
  (when has-fidget?
    (fidget.setup {})))
