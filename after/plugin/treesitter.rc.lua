local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

ts.setup({
  ensure_installed = "all",
  ignore_install = { "phpdoc" },
  highlight = { enable = true, addtional_vim_regex_highlighting = true },
  rainbow = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  context_commentstring = { enable = true },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
