(fn get_formatter []
  (let [(ok? formatter_config) (pcall require :formatter.config)]
    (when ok?
      (local formatters formatter_config.values.filetype)
      (local ft vim.bo.filetype)
      (. formatters ft)
      )))

:return {
  :get_formatter get_formatter
}
