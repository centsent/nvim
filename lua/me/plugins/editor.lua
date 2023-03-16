-- :fennel:1678790271
local function open_ssr()
  local ssr = require("ssr")
  return ssr.open()
end
local function _1_()
  local leap = require("leap")
  return leap.add_default_mappings()
end
return {{keys = {{desc = "Explorer NvimTree", "<leader>f", ":NvimTreeToggle<cr>"}}, opts = {disable_netrw = true}, "nvim-tree/nvim-tree.lua"}, {config = true, lazy = true, event = {"BufReadPost", "BufNewFile"}, "numToStr/Comment.nvim"}, {keys = {{desc = "Replace in files (ssr.nvim)", "<leader>sr", open_ssr}}, "cshuaimin/ssr.nvim"}, {event = {"BufNewFile", "BufReadPost"}, "gpanders/editorconfig.nvim"}, {config = true, event = {"BufNewFile", "BufReadPost"}, "windwp/nvim-autopairs"}, {config = true, event = {"BufNewFile", "BufReadPost"}, "kylechui/nvim-surround"}, {config = true, event = {"BufNewFile", "BufReadPost"}, "norcalli/nvim-colorizer.lua"}, {event = {"BufNewFile", "BufReadPost"}, config = _1_, "ggandor/leap.nvim"}}