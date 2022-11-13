-- :fennel:1668308652
local has_indent_3f, indent = pcall(require, "indent_blankline")
if has_indent_3f then
  return indent.setup({show_current_context = true, show_current_context_start = true})
else
  return nil
end