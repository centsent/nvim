(local M {})

(fn parse-sym [xs]
  "parses symbol 'xs' converts it to string if not a variable."
  (if (or (in-scope? xs) (not (sym? xs)))
      (do
        xs)
      (tostring xs)))

(fn M.nil? [x]
  "checks if value of 'x' is nil."
  `(= nil ,x))

(fn M.not-nil! [x]
  "checks if value of 'x' is not nil."
  `(not= nil ,x))

(fn M.tappend! [tbl val]
  "appends 'val' to a list 'tbl'."
  `(tset ,tbl (+ (length ,tbl) 1) ,val))

(fn M.g! [name val]
  "sets global variable 'name' to 'val'."
  `(tset vim.g ,(parse-sym name) ,val))

M

