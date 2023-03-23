-- :fennel:1679555729
local textobjects = {select = {enable = true}}
textobjects.select.keymaps = {ia = "@attribute.inner", iA = "@attribute.outer", ic = "@conditional.inner", iC = "@conditional.outer", ["if"] = "@function.inner", iF = "@function.outer", il = "@loop.inner", iL = "@loop.outer", ip = "@parameter.inner", iP = "@parameter.outer"}
local opts = {ensure_installed = "all", highlight = {enable = true, additional_vim_regex_highlighting = false}, rainbow = {enable = true}, indent = {enable = true}, autotag = {enable = true}, context_commentstring = {enable = true}, textobjects = textobjects}
local function config(_, settings)
  local ts = require("nvim-treesitter.configs")
  return ts.setup(settings)
end
local dependencies = {"windwp/nvim-ts-autotag", "p00f/nvim-ts-rainbow", "JoosepAlviste/nvim-ts-context-commentstring", "nvim-treesitter/nvim-treesitter-context", "nvim-treesitter/nvim-treesitter-textobjects"}
return {build = ":TSUpdate", opts = opts, config = config, dependencies = dependencies, event = {"BufReadPost", "BufNewFile"}, "nvim-treesitter/nvim-treesitter"}