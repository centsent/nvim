-- :fennel:1668302709
local has_comment_3f, Comment = pcall(require, "Comment")
if has_comment_3f then
  return Comment.setup()
else
  return nil
end