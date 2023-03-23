-- :fennel:1679577965
local function _1_()
  return (require("ssr")).open()
end
local function _2_()
  return (require("leap")).add_default_mappings()
end
return {{keys = {{desc = "Explorer NvimTree", "<leader>f", ":NvimTreeToggle<cr>"}}, opts = {disable_netrw = true}, "nvim-tree/nvim-tree.lua"}, {config = true, lazy = true, event = {"BufReadPost", "BufNewFile"}, "numToStr/Comment.nvim"}, {keys = {{desc = "Replace in files (ssr.nvim)", "<leader>sr", _1_}}, "cshuaimin/ssr.nvim"}, {event = {"BufNewFile", "BufReadPost"}, "gpanders/editorconfig.nvim"}, {config = true, event = {"BufNewFile", "BufReadPost"}, "windwp/nvim-autopairs"}, {config = true, event = {"BufNewFile", "BufReadPost"}, "kylechui/nvim-surround"}, {opts = {filetypes = {"*", "!lazy"}, buftype = {"*", "!prompt", "!nofile"}}, event = {"BufReadPre"}, "norcalli/nvim-colorizer.lua"}, {event = {"BufNewFile", "BufReadPost"}, config = _2_, "ggandor/leap.nvim"}}