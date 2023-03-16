-- :fennel:1678891038
local function setup_rust_analyzer(_, opts)
  local rust_tools = require("rust-tools")
  return rust_tools.setup({server = opts})
end
return {dependencies = {"simrat39/rust-tools.nvim"}, opts = {rust_analyzer = {}, setup = {rust_analyzer = setup_rust_analyzer}}, "neovim/nvim-lspconfig"}