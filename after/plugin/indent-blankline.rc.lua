local has_indent, indent = pcall(require, "indent_blankline")
if not has_indent then
  return
end

indent.setup({
  show_current_context = true,
  show_current_context_start = true,
})
