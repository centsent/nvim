(let [(has_indent? indent) (pcall require :indent_blankline)]
  (when has_indent?
    (indent.setup {
      :show_current_context true
      :show_current_context_start true
    })))
