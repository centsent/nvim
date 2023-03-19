-- :fennel:1679199608
local function _1_()
  return (require("neogen")).generate({})
end
return {{build = ":Codeium Auth", event = {"InsertEnter"}, dependencies = {"nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp"}, config = true, "jcdickinson/codeium.nvim"}, {keys = {{desc = "Symbols Outline", "<leader>cs", "<cmd>SymbolsOutline<cr>"}}, config = true, "simrat39/symbols-outline.nvim"}, {dependencies = {"nvim-treesitter/nvim-treesitter"}, keys = {{desc = "Neogen Comment", "<leader>cc", _1_}}, opts = {snippet_engine = "luasnip"}, "danymat/neogen"}}