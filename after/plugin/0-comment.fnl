(let [(has_comment? Comment) (pcall require :Comment)]
  (when has_comment?
    (Comment.setup)))

