local has_ts, ts = pcall(require, "nvim-treesitter.configs")
if not has_ts then
  return
end

local settings = {
  ensure_installed = "all",
  highlight = { enable = true },
  rainbow = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  context_commentstring = { enable = true },
}

ts.setup(settings)

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
