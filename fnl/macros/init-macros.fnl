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

(fn M.each! [tbl handler]
  "Iterate values in table/list with 'handler'."
  `(each [key# val# (pairs ,tbl)]
     (,handler key# val#)))

(fn M.ieach! [lst handler]
  "Iterate values in list with index and 'handler'."
  `(each [index# val# (ipairs ,lst)]
     (,handler val# index#)))

(fn M.g! [name val]
  "Sets vim global variable 'name' to 'val'."
  `(tset vim.g ,(parse-sym name) ,val))

M

