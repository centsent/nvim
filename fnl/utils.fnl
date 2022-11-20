(fn get_formatter []
  (let [(ok? formatter_config) (pcall require :formatter.config)]
    (when ok?
      (local formatters formatter_config.values.filetype)
      (local ft vim.bo.filetype)
      (. formatters ft))))

(fn get_formatter_name []
  (local formatter (get_formatter))
  (if formatter
      (do
        (local names {})
        (each [_ fmt_fn (ipairs formatter)]
          (local formatter (fmt_fn))
          (when formatter
            (tset names (+ (length names) 1) (or formatter.name formatter.exe))))
        (table.concat names ", "))
      ""))

(fn get_linter []
  (let [(has-lint? lint) (pcall require :lint)]
    (if has-lint?
        (. lint.linters_by_ft vim.bo.filetype)
        nil)))

(fn get_linter_name []
  (local linter (get_linter))
  (if linter
      (table.concat linter ", ")
      ""))

{: get_linter : get_linter_name : get_formatter : get_formatter_name}

