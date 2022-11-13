-- :fennel:1668307619
local has_ts_3f, ts = pcall(require, "nvim-treesitter.configs")
if has_ts_3f then
  local settings = {ensure_installed = "all", highlight = {enable = true}, rainbow = {enable = true}, indent = {enable = true}, autotag = {enable = true}, context_commentstring = {enable = true}, textobjects = {select = {enable = true, keymaps = {ia = "@attribute.inner", iA = "@attribute.outer", ic = "@conditional.inner", iC = "@conditional.outer", ["if"] = "@function.inner", iF = "@function.outer", il = "@loop.inner", iL = "@loop.outer", ip = "@parameter.inner", iP = "@parameter.outer"}}}}
  ts.setup(settings)
  local parser_config = (require("nvim-treesitter.parsers")).get_parser_configs()
  parser_config.tsx.filetype_to_parsername = {"javascript", "typescript.tsx"}
  local has_context_3f, context = pcall(require, "treesitter-context")
  if has_context_3f then
    return context.setup()
  else
    return nil
  end
else
  return nil
end